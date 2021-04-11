using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RotateForever : MonoBehaviour
{
    public Vector3 velocity = Vector3.up;
    // Update is called once per frame
    void Update()
    {
        transform.Rotate(velocity*Time.deltaTime);
    }
}
