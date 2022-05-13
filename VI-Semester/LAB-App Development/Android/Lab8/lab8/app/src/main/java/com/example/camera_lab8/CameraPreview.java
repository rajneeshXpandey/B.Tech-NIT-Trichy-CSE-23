package com.example.camera_lab8;

import android.content.Context;
import android.hardware.Camera;
import android.util.Log;
import android.view.SurfaceHolder;
import android.view.SurfaceView;

import java.io.IOException;

public class CameraPreview extends SurfaceView implements SurfaceHolder.Callback {

    private SurfaceHolder holder;
    private Camera camera;

    public CameraPreview(Context context, Camera camera) {
        super(context);
        this.camera = camera;
        holder = getHolder();
        holder.addCallback(this);
        holder.setType(SurfaceHolder.SURFACE_TYPE_PUSH_BUFFERS);
    }

    @Override
    public void surfaceCreated(SurfaceHolder surfaceHolder) {
        try {
            camera.setPreviewDisplay(surfaceHolder);
            camera.startPreview();
        }
        catch (IOException e) {
            Log.d("ERROR", "Error setting camera preview: " + e.getMessage());
        }
    }

    @Override
    public void surfaceChanged(SurfaceHolder surfaceHolder, int format, int w, int h) {
        if(holder.getSurface() == null)
            return;

        try {
            camera.stopPreview();
        }
        catch (Exception e) {
            e.printStackTrace();
        }

        // start preview with new settings
        try {
            camera.setPreviewDisplay(holder);
            camera.startPreview();
        }
        catch (Exception e){
            Log.d("ERROR", "Error starting camera preview: " + e.getMessage());
        }
    }

    @Override
    public void surfaceDestroyed(SurfaceHolder surfaceHolder) {

    }
}