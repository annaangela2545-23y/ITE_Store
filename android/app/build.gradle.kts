plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {

    flavorDimensions +="default"
    namespace = "com.example.flutter_ite_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion
    productFlavors{
        create("dev") {
            dimension = "default"
            applicationId = "kh.edu.rupp.itestore.dev"
            resValue("string", "app_name", "ITE Store DEV")
        }
        create("uat") {
            dimension = "default"
            applicationId = "kh.edu.rupp.itestore.uat"
            resValue("string", "app_name", "ITE Store UAT")
        }
        create("demo") {
            dimension = "default"
            applicationId = "kh.edu.rupp.itestore.demo"
            resValue("string", "app_name", "ITE Store DEMO")
        }
        create("prod") {
            dimension = "default"
            applicationId = "kh.edu.rupp.itestore"
            resValue("string", "app_name", "ITE Store")
        }
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.flutter_ite_app"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
