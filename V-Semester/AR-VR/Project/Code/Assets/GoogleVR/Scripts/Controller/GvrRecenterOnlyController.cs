// Copyright 2017 Google Inc. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

using UnityEngine;
using UnityEngine.XR;

// Recenter only the controller.
// Usage: Set GvrControllerPointer > Controller as the pointer field, and
// the camera to recenter (e.g. Main Camera).
public class GvrRecenterOnlyController : MonoBehaviour {
  private Quaternion recenteringOffset = Quaternion.identity;

  [Tooltip("The controller to recenter")]
  public GameObject pointer;

  [Tooltip("The camera to recenter")]
  public Camera cam;

  void Start() {
    if (cam == null) {
      cam = Camera.main;
    }
  }

  void Update() {
    if (cam == null || pointer == null
       || GvrControllerInput.State != GvrConnectionState.Connected) {
      return;
    }
    // Daydream is loaded only on deivce, not in editor.
#if UNITY_ANDROID && !UNITY_EDITOR
        if (UnityEngine.XR.XRSettings.loadedDeviceName != "daydream")
        {
            return;
        }
#endif
    if (GvrControllerInput.Recentered) {
      pointer.transform.rotation = recenteringOffset;
      cam.transform.parent.rotation = recenteringOffset;
      return;
    }

#if !UNITY_EDITOR
    if (GvrControllerInput.HomeButtonDown || GvrControllerInput.HomeButtonState) {
      return;
    }
#endif  // !UNITY_EDITOR
    recenteringOffset = Quaternion.Euler(0, cam.transform.rotation.eulerAngles.y, 0);
  }

  void OnDisable() {
    recenteringOffset = Quaternion.identity;
    if (cam != null && pointer != null) {
      pointer.transform.rotation = recenteringOffset;
      cam.transform.parent.rotation = recenteringOffset;
    }
  }

}
