using System;
using System.Collections.Generic;
using UnityEngine;

namespace Axie.OriginsKit
{
    [Serializable]
    public class SkillVfxMap
    {
        public string abilityId;
        public string[] cardNames;
        public string partClass;
        public string partType;
        public string attackType;
        public string vfxId;
        public string attackAnimation;
        public string hitAnimation;
        public bool isRanged;
        public float duration;
        public float projectileTravel;
    }

    [Serializable]
    public class ActivationKey
    {
        public float time;
        public bool active;
    }

    [Serializable]
    public class ActivationTrack
    {
        public string path;
        public ActivationKey[] keys;
    }

    [Serializable]
    public class ClipEvent
    {
        public float time;
        public string function;
        public string @string;
        public float @float;
    }

    [Serializable]
    public class EffectActivation
    {
        public string id;
        public string kind;
        public float duration;
        public ClipEvent[] events;
        public ActivationTrack[] activations;
        public int childCount;
    }

    /// <summary>
    /// Loads the JSON catalogs shipped in Resources/OriginsKit/Catalogs.
    /// </summary>
    public static class OriginsCatalog
    {
        static List<SkillVfxMap> _skills;
        static Dictionary<string, EffectActivation> _activation;

        public static IReadOnlyList<SkillVfxMap> Skills
        {
            get
            {
                if (_skills == null) Load();
                return _skills;
            }
        }

        public static EffectActivation GetActivation(string vfxId)
        {
            if (_activation == null) Load();
            EffectActivation found;
            return _activation.TryGetValue(vfxId, out found) ? found : null;
        }

        public static SkillVfxMap FindAbility(string abilityId)
        {
            foreach (var s in Skills)
                if (s.abilityId == abilityId) return s;
            return null;
        }

        static void Load()
        {
            _skills = new List<SkillVfxMap>();
            _activation = new Dictionary<string, EffectActivation>();
            var skillText = Resources.Load<TextAsset>("OriginsKit/Catalogs/skill-vfx");
            if (skillText != null)
            {
                var wrap = JsonUtility.FromJson<SkillList>(skillText.text);
                if (wrap != null && wrap.items != null)
                    _skills.AddRange(wrap.items);
            }
            var actText = Resources.Load<TextAsset>("OriginsKit/Catalogs/activation");
            if (actText != null)
            {
                var wrap = JsonUtility.FromJson<ActList>(actText.text);
                if (wrap != null && wrap.items != null)
                    foreach (var item in wrap.items)
                        if (item != null && !string.IsNullOrEmpty(item.id))
                            _activation[item.id] = item;
            }
        }

        [Serializable]
        class SkillList { public SkillVfxMap[] items; }

        [Serializable]
        class ActList { public EffectActivation[] items; }
    }
}
