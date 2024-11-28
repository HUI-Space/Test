using System;
using System.Collections;
using System.Collections.Generic;
using System.Threading.Tasks;
using UnityEngine;
using UnityEngine.AddressableAssets;

public class Collider : MonoBehaviour
{
    private void Awake()
    {
        
    }

    private async void LoadP()
    {
        AssetBundle assetBundle = await Load("");
        Addressables.LoadAssetAsync<GameObject>("");
    }
    

    private async Task<AssetBundle> Load(string path)
    {
        TaskCompletionSource<AssetBundle> taskCompletionSource = new TaskCompletionSource<AssetBundle>();
        AssetBundleCreateRequest assetBundleCreateRequest = AssetBundle.LoadFromFileAsync(path);
        assetBundleCreateRequest.completed += operation =>
        {
            taskCompletionSource.SetResult(assetBundleCreateRequest.assetBundle);
        };
        return await taskCompletionSource.Task;
    }

    private void OnCollisionEnter(Collision other)
    {
        Debug.Log("产生碰撞了");
        StartCoroutine(WaitAndDestroy());
    }

    IEnumerator WaitAndDestroy()
    {
        Debug.Log("播放特效");
        yield return new WaitForSeconds(3F);
        Debug.Log("销毁了");
        Destroy(this.gameObject);
    }
}
