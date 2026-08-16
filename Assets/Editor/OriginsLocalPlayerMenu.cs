using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering.Universal;
using Axie.OriginsKit;

public static class OriginsLocalPlayerMenu
{
    const string ScenePath = "Assets/OriginsKit/Scenes/VfxLocalPlayer.unity";

    [MenuItem("Origins/Play Local Player")]
    public static void Play()
    {
        if (!System.IO.File.Exists(ScenePath)) Setup();
        EditorSceneManager.OpenScene(ScenePath);
        EditorApplication.isPlaying = true;
    }

    [MenuItem("Origins/Setup Local Player")]
    public static void Setup()
    {
        var scene = EditorSceneManager.NewScene(NewSceneSetup.EmptyScene, NewSceneMode.Single);
        var camGo = new GameObject("Camera");
        var cam = camGo.AddComponent<Camera>();
        cam.tag = "MainCamera";
        cam.orthographic = true;
        cam.orthographicSize = 6.1f;
        cam.transform.position = new Vector3(0f, -0.35f, -20f);
        cam.backgroundColor = new Color(0.075f, 0.086f, 0.106f, 1f);
        cam.clearFlags = CameraClearFlags.SolidColor;
        cam.nearClipPlane = -80f;
        cam.farClipPlane = 80f;
        camGo.AddComponent<AudioListener>();
        camGo.AddComponent<UniversalAdditionalCameraData>();

        var lightGo = new GameObject("Light");
        var light = lightGo.AddComponent<Light>();
        light.type = LightType.Directional;
        light.intensity = 1.05f;
        lightGo.transform.rotation = Quaternion.Euler(50f, -30f, 0f);

        var playerGo = new GameObject("VfxLocalPlayer");
        var player = playerGo.AddComponent<VfxLocalPlayer>();
        player.viewCamera = cam;

        System.IO.Directory.CreateDirectory("Assets/OriginsKit/Scenes");
        EditorSceneManager.SaveScene(scene, ScenePath);
        Debug.Log("Kit local player scene ready: " + ScenePath);
    }
}
