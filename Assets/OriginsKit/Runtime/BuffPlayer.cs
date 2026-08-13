using UnityEngine;

namespace Axie.OriginsKit
{
    /// <summary>
    /// Plays an Origins BuffEffect prefab. Buffs use the same Animator
    /// "skill" trigger as skills. Set looping on the clip or replayDelay
    /// for persistent statuses (sleep, stun, shield).
    /// </summary>
    [DisallowMultipleComponent]
    public class BuffPlayer : MonoBehaviour
    {
        public AnimationClip clip;
        public bool looping;

        Animator _animator;
        static readonly int SkillTrigger = Animator.StringToHash("skill");

        void Awake()
        {
            _animator = GetComponent<Animator>();
            if (_animator == null) _animator = gameObject.AddComponent<Animator>();
        }

        void Start()
        {
            BindClip();
            Play();
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
            if (_animator == null || clip == null) return;
            _animator.ResetTrigger(SkillTrigger);
            _animator.SetTrigger(SkillTrigger);
            _animator.Play("skill", 0, 0f);
        }

        public static BuffPlayer Spawn(GameObject prefab, Transform host)
        {
            var instance = Instantiate(prefab, host);
            instance.name = prefab.name;
            instance.transform.localPosition = Vector3.zero;
            instance.transform.localScale = Vector3.one * SkillPlayer.GameScale;
            instance.SetActive(true);
            var player = instance.GetComponent<BuffPlayer>();
            if (player == null) player = instance.AddComponent<BuffPlayer>();
            return player;
        }
    }
}
