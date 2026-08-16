using UnityEngine;

namespace Axie.OriginsKit
{
    /// <summary>
    /// Interactive local player for kit prefabs. Arrow keys cycle,
    /// Space replays. Same spawn contract as SkillPlayer / BuffPlayer.
    /// </summary>
    public class VfxLocalPlayer : MonoBehaviour
    {
        public Camera viewCamera;
        string[] _ids;
        int _index;
        GameObject _holder;

        void Start()
        {
            _ids = ListIds();
            if (_ids.Length > 0) Play(_ids[0]);
        }

        void Update()
        {
            if (Input.GetKeyDown(KeyCode.RightArrow) || Input.GetKeyDown(KeyCode.D)) Next(1);
            if (Input.GetKeyDown(KeyCode.LeftArrow) || Input.GetKeyDown(KeyCode.A)) Next(-1);
            if (Input.GetKeyDown(KeyCode.Space) && _ids.Length > 0) Play(_ids[_index]);
        }

        void OnGUI()
        {
            var id = _ids != null && _ids.Length > 0 ? _ids[_index] : "";
            GUI.color = new Color(1f, 0.58f, 0.27f, 0.95f);
            GUI.Label(new Rect(16, 12, 900, 24), "Origins kit player  ·  ← → cycle  ·  Space replay");
            GUI.color = Color.white;
            GUI.Label(new Rect(16, 34, 900, 22), (_index + 1) + " / " + (_ids != null ? _ids.Length : 0) + "   " + id);
        }

        void Next(int delta)
        {
            if (_ids == null || _ids.Length == 0) return;
            _index = (_index + delta + _ids.Length) % _ids.Length;
            Play(_ids[_index]);
        }

        public void Play(string id)
        {
            if (_holder != null) Destroy(_holder);
            var prefab = Resources.Load<GameObject>("ImportedVfx/" + id);
            if (prefab == null)
            {
                Debug.LogWarning("Missing " + id);
                return;
            }
            var clip = Resources.Load<AnimationClip>("ImportedVfx/" + id);
            _holder = new GameObject("holder-" + id);
            _holder.transform.localScale = Vector3.one / SkillPlayer.GameScale;
            var instance = Instantiate(prefab, _holder.transform);
            instance.name = id;
            instance.SetActive(true);
            instance.transform.localPosition = Vector3.zero;
            instance.transform.localScale = Vector3.one * SkillPlayer.GameScale;

            var hasDefender = false;
            foreach (var t in instance.GetComponentsInChildren<Transform>(true))
                if (t.name == "@defender") hasDefender = true;
            _holder.transform.position = hasDefender ? new Vector3(4.4f, -0.6f, 0f) : Vector3.zero;

            if (hasDefender)
            {
                var player = instance.GetComponent<SkillPlayer>() ?? instance.AddComponent<SkillPlayer>();
                player.clip = clip;
                player.replayDelay = 0.55f;
                player.BindClip();
                player.Play();
            }
            else
            {
                var player = instance.GetComponent<BuffPlayer>() ?? instance.AddComponent<BuffPlayer>();
                player.clip = clip;
                player.BindClip();
                player.Play();
            }

            var cam = viewCamera != null ? viewCamera : Camera.main;
            if (cam != null)
            {
                cam.orthographic = true;
                cam.orthographicSize = hasDefender ? 6.1f : 4.6f;
                cam.transform.position = hasDefender ? new Vector3(0f, -0.35f, -20f) : new Vector3(0f, 0.85f, -20f);
                cam.backgroundColor = new Color(0.075f, 0.086f, 0.106f, 1f);
                cam.clearFlags = CameraClearFlags.SolidColor;
            }
        }

        static string[] ListIds()
        {
            var list = new System.Collections.Generic.List<string>();
            foreach (var prefab in Resources.LoadAll<GameObject>("ImportedVfx"))
            {
                if (prefab == null) continue;
                if (prefab.name == "Melee" || prefab.name == "Ranged") continue;
                list.Add(prefab.name);
            }
            list.Sort(System.StringComparer.OrdinalIgnoreCase);
            return list.ToArray();
        }
    }
}
