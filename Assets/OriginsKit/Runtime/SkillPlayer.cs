using System.Collections;
using UnityEngine;

namespace Axie.OriginsKit
{
    /// <summary>
    /// Plays an Origins SkillEffect prefab the same way battle does:
    /// AnimatorOverrideController on the "skill" clip, animation events,
    /// @defender / @projectile / @flipX / @scaleX markers.
    /// </summary>
    [DisallowMultipleComponent]
    public class SkillPlayer : MonoBehaviour
    {
        public const float GameScale = 54f;

        public AnimationClip clip;
        public Transform defenderTarget;
        public bool rotateProjectile = true;
        public float replayDelay = -1f;

        public event System.Action<SkillPlayer, string> Attack;
        public event System.Action<SkillPlayer, float> Throw;
        public event System.Action<SkillPlayer, string> Hit;
        public event System.Action<SkillPlayer> Started;
        public event System.Action<SkillPlayer> Ended;

        Animator _animator;
        Transform _defender;
        Transform _projectile;
        Vector3 _projectileHome;
        Coroutine _throwMove;
        bool _replaying;
        static readonly int SkillTrigger = Animator.StringToHash("skill");

        void Awake()
        {
            _animator = GetComponent<Animator>();
            if (_animator == null) _animator = gameObject.AddComponent<Animator>();
            foreach (var t in GetComponentsInChildren<Transform>(true))
            {
                if (t.name == "@defender") _defender = t;
                if (t.name == "@projectile")
                {
                    _projectile = t;
                    _projectileHome = t.localPosition;
                }
            }
        }

        void Start()
        {
            BindClip();
            Play();
        }

        void Update()
        {
            if (_animator == null || clip == null || replayDelay < 0f || _replaying) return;
            var info = _animator.GetCurrentAnimatorStateInfo(0);
            if (info.IsName("skill") && info.normalizedTime >= 1f)
                StartCoroutine(ReplaySoon());
        }

        void LateUpdate()
        {
            var leftSide = transform.lossyScale.x < 0;
            if (_defender != null && defenderTarget != null)
                _defender.position = defenderTarget.position;

            foreach (var child in GetComponentsInChildren<Transform>(true))
            {
                if (child.name.Contains("@scaleX"))
                {
                    var scale = child.localScale;
                    scale.x = leftSide ? Mathf.Abs(scale.x) : -Mathf.Abs(scale.x);
                    child.localScale = scale;
                }
                if (child.name.Contains("@flipX"))
                {
                    var render = child.GetComponent<ParticleSystemRenderer>();
                    if (render == null) continue;
                    var flip = render.flip;
                    flip.x = leftSide ? 1 : 0;
                    render.flip = flip;
                }
            }
        }

        public void BindClip()
        {
            if (clip == null)
                clip = Resources.Load<AnimationClip>("ImportedVfx/" + name)
                       ?? Resources.Load<AnimationClip>("OriginsKit/Animations/" + name);
            var controller = Resources.Load<RuntimeAnimatorController>("Effects/AnimatorController")
                             ?? Resources.Load<RuntimeAnimatorController>("OriginsKit/Effects/AnimatorController");
            if (controller == null || clip == null) return;
            var overrideController = new AnimatorOverrideController(controller) { name = name };
            overrideController["skill"] = clip;
            _animator.runtimeAnimatorController = overrideController;
        }

        public void Play()
        {
            gameObject.SetActive(true);
            if (_projectile != null)
            {
                _projectile.localPosition = _projectileHome;
                if (_throwMove != null) StopCoroutine(_throwMove);
            }
            if (_animator != null && clip != null)
            {
                _animator.ResetTrigger(SkillTrigger);
                _animator.SetTrigger(SkillTrigger);
                _animator.Play("skill", 0, 0f);
            }
            Started?.Invoke(this);
        }

        public static SkillPlayer Spawn(GameObject prefab, Vector3 worldPosition, Transform parent = null)
        {
            var instance = Instantiate(prefab, worldPosition, Quaternion.identity, parent);
            instance.name = prefab.name;
            instance.transform.localScale = Vector3.one * GameScale;
            instance.SetActive(true);
            var player = instance.GetComponent<SkillPlayer>();
            if (player == null) player = instance.AddComponent<SkillPlayer>();
            return player;
        }

        IEnumerator ReplaySoon()
        {
            if (_replaying) yield break;
            _replaying = true;
            yield return new WaitForSeconds(replayDelay);
            _replaying = false;
            Play();
        }

        public void OnStartLoop() { }

        public void OnAttack(string animAttack)
        {
            Attack?.Invoke(this, animAttack);
        }

        public void OnThrow(float duration)
        {
            Throw?.Invoke(this, duration);
            if (_projectile == null) return;
            var target = defenderTarget != null
                ? defenderTarget.position
                : (_defender != null ? _defender.position : _projectile.position + Vector3.left * 4.2f);
            if (_throwMove != null) StopCoroutine(_throwMove);
            _throwMove = StartCoroutine(MoveProjectile(target, Mathf.Max(0.05f, duration)));
        }

        public void OnHit(string animDefense)
        {
            Hit?.Invoke(this, animDefense);
        }

        public void OnEndLoop()
        {
            if (replayDelay >= 0f) StartCoroutine(ReplaySoon());
        }

        public void OnBack()
        {
            Ended?.Invoke(this);
        }

        IEnumerator MoveProjectile(Vector3 target, float duration)
        {
            var start = _projectile.position;
            var t = 0f;
            if (rotateProjectile)
            {
                var dir = target - start;
                var angle = Mathf.Atan2(dir.y, dir.x) * Mathf.Rad2Deg;
                _projectile.rotation = Quaternion.AngleAxis(angle, Vector3.forward);
            }
            while (t < 1f && _projectile != null)
            {
                t += Time.deltaTime / duration;
                _projectile.position = Vector3.Lerp(start, target, Mathf.Clamp01(t));
                yield return null;
            }
        }
    }
}
