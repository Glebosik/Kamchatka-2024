package com.example.kamchatka

import android.app.Application

import com.yandex.mapkit.MapKitFactory

class MainApplication: Application() {
  override fun onCreate() {
    super.onCreate()
    MapKitFactory.setLocale("ru_RU") // Your preferred language. Not required, defaults to system language
    MapKitFactory.setApiKey("b8d013d6-f60c-4881-8662-2ef967909f8c") // Your generated API key
  }
}