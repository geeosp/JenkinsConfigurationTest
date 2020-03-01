using System.Collections.Generic;
using UnityEditor;
using System;
class AutoBuildScript
{
    static private string[] SCENES = FindEnabledEditorScenes();

    static private string APP_NAME = PlayerSettings.productName;
    static private string TARGET_DIR = "Builds";

    static private BuildOptions ReleaseBuildOptions = BuildOptions.DetailedBuildReport;
    static private BuildOptions DevelopmentBuildOptions = BuildOptions.Development | BuildOptions.AllowDebugging | BuildOptions.DetailedBuildReport;
    public static string Path
    {
        get { return EditorPrefs.GetString("AndroidSdkRoot"); }
        set { EditorPrefs.SetString("AndroidSdkRoot", value); }
    }



    #region WindowsStandAlone
    [MenuItem("Build/CI/Windows StandAlone Release")]
    static void PerformWindowsBuild()
    {
        string target_dir = APP_NAME + ".exe";
        GenericBuild(SCENES, TARGET_DIR + "/windows/release/" + GetDateString() + "/" + target_dir, BuildTargetGroup.Standalone, BuildTarget.StandaloneWindows64, ReleaseBuildOptions);
    }
    [MenuItem("Build/CI/Windows StandAlone Development")]
    static void PerformWindowsBuildDevelop()
    {
        string targetDir = APP_NAME + ".exe";
        GenericBuild(SCENES, TARGET_DIR + "/windows/development/" + GetDateString() + "/" + targetDir, BuildTargetGroup.Standalone, BuildTarget.StandaloneWindows64, DevelopmentBuildOptions);
    }
    #endregion

    #region Windows_App_Store
    [MenuItem("Build/CI/Windows Universal App Store")]
    static void PerformWindowsUniversalAppStoreBuild()
    {
        string target_dir = APP_NAME;// + ".exe";
        GenericBuild(SCENES, TARGET_DIR + "/windows/release/" + GetDateString() + "/" + target_dir, BuildTargetGroup.WSA, BuildTarget.WSAPlayer, BuildOptions.None);
    }
    [MenuItem("Build/CI/Windows Universal App Store Development")]
    static void PerformWindowsUniversalAppStoreBuildDevelop()
    {
        string targetDir = APP_NAME;// + "_dev.exe";
        GenericBuild(SCENES, TARGET_DIR + "/windows/development/" + GetDateString() + "/" + targetDir, BuildTargetGroup.WSA, BuildTarget.WSAPlayer, BuildOptions.Development | BuildOptions.AllowDebugging);
    }
    #endregion

    #region Android
    [MenuItem("Build/CI/Android")]
    static void PerformAndroidBuild()
    {

        string targetDir = APP_NAME + ".aab";
        GenericBuild(SCENES, TARGET_DIR + "/android/release" + GetDateString() + "/" + targetDir, BuildTargetGroup.Android, BuildTarget.Android, ReleaseBuildOptions);
    }
    [MenuItem("Build/CI/Android Dev")]
    static void PerformAndroidBuildDev()
    {

        string targetDir = APP_NAME + ".aab";
        GenericBuild(SCENES, TARGET_DIR + "/android/development/" + GetDateString() + "/" + targetDir, BuildTargetGroup.Android, BuildTarget.Android, DevelopmentBuildOptions);
    }
    #endregion




    #region Utilities
    private static string[] FindEnabledEditorScenes()
    {
        List<string> EditorScenes = new List<string>();
        foreach (EditorBuildSettingsScene scene in EditorBuildSettings.scenes)
        {
            if (!scene.enabled)
            {
                continue;
            }

            EditorScenes.Add(scene.path);
        }
        return EditorScenes.ToArray();
    }

    static void GenericBuild(string[] scenes, string target_dir, BuildTargetGroup group, BuildTarget build_target, BuildOptions build_options)
    {
        EditorUserBuildSettings.SwitchActiveBuildTarget(group, build_target);
        BuildPipeline.BuildPlayer(scenes, target_dir, build_target, build_options);

    }
    private static string GetDateString()
    {
        string s = "";
        // s = System.DateTime.Now.Day.ToString("yyyymmdd");
        return s;
    }
    #endregion
}
