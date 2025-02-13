package com.example.trogon_test

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.webkit.JavascriptInterface
import android.webkit.WebResourceRequest
import android.webkit.WebView
import android.webkit.WebViewClient
import android.widget.FrameLayout
import android.widget.ProgressBar
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.launch
import kotlinx.coroutines.delay

class MultiVideoView(
    context: Context,
    messenger: BinaryMessenger,
    id: Int,
    creationParams: Map<String?, Any?>?
) : PlatformView {

    private val view: View = LayoutInflater.from(context).inflate(R.layout.native_video_view, null, false)
    private val webView: WebView = view.findViewById(R.id.webView)
    private val progressBar: ProgressBar = view.findViewById(R.id.loadingIndicator)
    private var playingPositionJob: Job? = null
    private val methodChannel = MethodChannel(messenger, "multi_video_player")

    init {
        webView.settings.javaScriptEnabled = true
        webView.settings.mediaPlaybackRequiresUserGesture = false
        webView.settings.allowFileAccess = true
        webView.settings.domStorageEnabled = true

        webView.addJavascriptInterface(object {
            @JavascriptInterface
            fun onPositionChanged(position: Double) {
                CoroutineScope(Dispatchers.Main).launch {
                    methodChannel.invokeMethod("onPositionChanged", position)
                }
            }
        }, "Android")

        webView.webViewClient = object : WebViewClient() {
            override fun onPageFinished(view: WebView?, url: String?) {
                when {
                    url?.contains("youtube.com") == true -> injectYouTubeJS()
                    url?.contains("vimeo.com") == true -> injectVimeoJS()
                }
                progressBar.visibility = View.GONE
                webView.visibility = View.VISIBLE
            }
        }

        webView.loadUrl(creationParams?.get("url") as? String ?: "")
    }

    // 🎯 Inject JavaScript for YouTube
    private fun injectYouTubeJS() {
        val jsCode = """
            function hideElements() {
                var fullscreenButton = document.getElementsByClassName("ytp-fullscreen-button ytp-button");
                for (var i=0; i<fullscreenButton.length; i++){ fullscreenButton[i].style.display = 'none'; }

                var logo = document.getElementsByClassName("ytp-youtube-button ytp-button yt-uix-sessionlink");
                for (var i=0; i<logo.length; i++){ logo[i].style.display = 'none'; }

                var title = document.getElementsByClassName("ytp-chrome-top ytp-show-cards-title");
                for (var i=0; i<title.length; i++){ title[i].style.display = 'none'; }

                var video = document.querySelector('video');
                video.addEventListener('timeupdate', function() {
                    var position = video.currentTime;
                    Android.onPositionChanged(position);
                });
            }

            hideElements();
            setInterval(hideElements, 500);
        """
        webView.evaluateJavascript(jsCode, null)
    }

    // 🎯 Inject JavaScript for Vimeo
    private fun injectVimeoJS() {
        val jsCode = """
            function hideVimeoElements() {
                // Hide the Vimeo logo button
                var vimeoLogoButton = document.querySelectorAll('a[data-vimeo-logo="true"]');
                for (var i = 0; i < vimeoLogoButton.length; i++) {
                    vimeoLogoButton[i].style.display = 'none';
                }
    
                // Hide the Vimeo small SVG logo
                var vimeoSvgLogo = document.querySelectorAll('svg[data-vimeo-small-icon="true"]');
                for (var i = 0; i < vimeoSvgLogo.length; i++) {
                    vimeoSvgLogo[i].style.display = 'none';
                }
    
                // Hide other branding elements
                var brandingElements = document.querySelectorAll('.vp-title, .vp-title a, .vp-logo');
                for (var i = 0; i < brandingElements.length; i++) {
                    brandingElements[i].style.display = 'none';
                }
    
                // Hide unnecessary buttons
                var buttons = document.querySelectorAll('.vp-controls .vp-playlist-btn, .vp-branding');
                for (var i = 0; i < buttons.length; i++) {
                    buttons[i].style.display = 'none';
                }
            }
    
            hideVimeoElements();
            setInterval(hideVimeoElements, 500);
        """
        webView.evaluateJavascript(jsCode, null)
    }
    
    
    
    

    override fun getView(): View {
        return view
    }

    override fun dispose() {
        playingPositionJob?.cancel()
    }
}

class MultiVideoViewFactory(private val messenger: BinaryMessenger) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, id: Int, creationParams: Any?): PlatformView {
        return MultiVideoView(context,messenger, id, creationParams as Map<String?, Any?>?)
    }
}
