/*
* Copyright (C) 2011 Texas Instruments Inc.
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*      http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

package com.ti.s3d;

import android.view.Surface;
import android.view.SurfaceHolder;

/**
   S3DView provides a mechanism to inform the surface composer (SurfaceFlinger)
   that stereoscopic content is being rendered unto a surface.
   <br /><br />
   Currently S3DView only supports this mechanism when using SurfaceView, as
   a dedicated surface is needed.
   <br /><br />
   The typical use is:<br />
   <p><blockquote><pre>
   SurfaceView view = new SurfaceView(context);<br />
   SurfaceHolder holder = view.getHolder();<br />
   S3DView s3dView = S3DView(holder, Layout.SIDE_BY_SIDE_LR, RenderMode.STEREO);
   </pre></blockquote>
   On your manifest file you will have to add:
   <p><blockquote><pre>
   {@code <uses-library android:name="com.ti.s3d" android:required="false" />}
   </pre></blockquote>

   If you are using a native build, you will have to add to your Androd.mk file:
   <p><blockquote><pre>
   LOCAL_JAVA_LIBRARIES := com.ti.s3d
   </pre></blockquote>
   @author Alberto Aguirre
   @author Jagadeesh Pakaravoor
   @version 1.0, Nov 2011
 */

public class S3DView implements SurfaceHolder.Callback {

    /**
      Equivalent to S3DView(Layout.SIDE_BY_SIDE_LR, RenderMode.STEREO)
      @see #S3DView(SurfaceHolder, Layout, RenderMode)
    */
    public S3DView(SurfaceHolder sh) {
        this(sh, Layout.SIDE_BY_SIDE_LR, RenderMode.STEREO);
    }

    /**
      Standard constructor. It registers callback with SurfaceHolder.
      Typically this is called before SurfaceView has been layed out.
      If SurfaceView already contains a valid surface, then the configuration
      is performed during the constructor
      @param sh The holder associated with the SurfaceView where stereo content will be rendered to.
      @param layout Describes in which position the stereo views are rendered as.
      @param mode Describes if the stereo view should be rendered in stereo or just one of the views
    */
    public S3DView(SurfaceHolder sh, Layout layout, RenderMode mode) {
        nativeClassInit();
        sh.addCallback(this);
        this.layout = layout;
        this.mode = mode;
        if(sh.getSurface().isValid()) {
            this.holder = sh;
            config();
        }
    }

    /**
      Changes the current layout and render mode. Typically this is used when
      you reuse the same Surfaceview to render mono content, or potentially after
      a system orientation change, where the preferred layout has changed.
      @param layout Describes in which position the stereo views are rendered as.
      @param mode Describes if the stereo view should be rendered in stereo or just one of the views
      @see #getPrefLayout
    */
    public void setConfig(S3DView.Layout layout, S3DView.RenderMode mode) {
        this.layout = layout;
        this.mode = mode;
        config();
    }

    /**
      Only the layout is changed. The RenderMode remains set to its current value.
      @param layout Describes in which position the stereo views are rendered as.
      @see S3DView.Layout
    */
    public void setLayout(S3DView.Layout layout) {
        this.layout = layout;
        config();
    }

    /**
      Only the render mode is changed. The layout remains set to its current value.
      @param mode Describes in which position the stereo views are rendered as.
      @see S3DView.Layout
    */
    public void setMode(S3DView.RenderMode mode) {
        this.mode = mode;
        config();
    }

    /**
      Swaps the left and right view. Useful mainly in cases where the rendering is not done
      by the owner of this view, for example Camera or Video.
    */
    public void swapLR() {
        layout = layout.swapLR();
        config();
    }

    /**
      Informs what is the preferred layout for the default display.
      To minimize aliasing artifacts when dealing with interleaved S3D displays,
      the user should render in the layout described here.
      @return The layout preferred by the default display
    */
    public S3DView.Layout getPrefLayout() {
        return native_getPrefLayout();
    }

    /**
      SurfaceHolder.Callback implementation.
    */
    public void surfaceChanged(SurfaceHolder holder, int format, int width, int height) {
        this.holder = holder;
        config();
    }

    /**
      SurfaceHolder.Callback implementation.
    */
    public void surfaceCreated(SurfaceHolder holder) {};

    /**
      SurfaceHolder.Callback implementation.
    */
    public void surfaceDestroyed(SurfaceHolder holder) {
        this.holder = null;
    };

    private void config() {
        if (holder != null)
            native_setConfig(holder.getSurface(), layout.getType(),
                            layout.getLayoutOrder(), mode.getMode());
    }

    /**
      The supported stereo layouts
    */
    public static enum Layout {
        /**
          Signals no stereo content is rendered
        */
        MONO (0, 0) { Layout swapLR() { return MONO; }},
         /**
         App renders left view  on the surface's left half,
         and the right view on the surface's right half.
        */
        SIDE_BY_SIDE_LR (1, 0) { Layout swapLR() { return SIDE_BY_SIDE_RL; } },
        /**
         App renders left view  on the surface's right half,
         and the right view on the surface's left half.
        */
        SIDE_BY_SIDE_RL (1, 1) { Layout swapLR() { return SIDE_BY_SIDE_LR; } },
        /**
         App renders left view  on the surface's top half,
         and the right view on the surface's bottom half.
        */
        TOPBOTTOM_L (2, 0) { Layout swapLR() { return TOPBOTTOM_R; } },
        /**
         App renders left view  on the surface's bottom half,
         and the right view on the surface's top half.
        */
        TOPBOTTOM_R (2, 1) { Layout swapLR() { return TOPBOTTOM_L; } };

        private final int type;
        private final int layoutOrder;

        private Layout(int typ, int layoutOrder) {
            this.type = typ;
            this.layoutOrder = layoutOrder;
        }

        abstract Layout swapLR();
        private int getType() { return type; }
        private int getLayoutOrder() { return layoutOrder; }
    }

    /**
      The supported rendering modes
    */
    public static enum RenderMode {
        /**
            The surface composer will only render the left view of the surface.
        */
        MONO_LEFT(0),
        /**
            The surface composer will only render the right view of the surface.
        */
        MONO_RIGHT(1),
        /**
            The surface composer will render both views as appropiate for the default display.
        */
        STEREO(2);

        private final int mode;
        private RenderMode(int mode) { this.mode = mode; }
        private int getMode() { return mode; }
    }

    static {
        System.loadLibrary("s3dview_jni");
    }

    private Layout layout;
    private RenderMode mode;
    private SurfaceHolder holder;

    private native void native_setConfig(Surface s, int type, int order, int mode);
    private native S3DView.Layout native_getPrefLayout();
    private native void nativeClassInit();

};
