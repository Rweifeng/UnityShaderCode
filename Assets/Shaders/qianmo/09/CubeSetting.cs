using UnityEngine;
using System.Collections;

public class CubeSetting : MonoBehaviour {

    private Material material;
    private float time;
	// Use this for initialization
	void Start () {
        material = GetComponent<Renderer>().material;
    }
	
	// Update is called once per frame
	void Update () {
        time -= Time.deltaTime;
        material.SetFloat("_CurTime", time);
        if (time < -20)
        {
            time = 0;
        }
	}
}
