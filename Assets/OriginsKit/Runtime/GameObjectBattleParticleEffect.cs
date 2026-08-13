using UnityEngine;

namespace Axie
{
    /// <summary>
    /// Standalone stub of Origins' battle particle host. Prefabs keep their
    /// original script GUID so they open without missing-script errors.
    /// ParticleSystems still play on awake.
    /// </summary>
    public class GameObjectBattleParticleEffect : MonoBehaviour
    {
        public float duration = 1f;
        public string sortingLayer = "Effect";
    }
}
