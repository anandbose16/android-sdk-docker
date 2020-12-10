# Android SDK Docker Images
This container image contains Android SDK 30 with build tools 30.0.3. You can use this for building Android projects in your workstation, cloud or VCS pipelines.

## Usage

Pull the image from docker hub

```bash
docker pull anandbose16/android-sdk:30.0.3
```
Run the container with your project directory as a volume.

```bash
docker run -it -v /path/to/project:/project anandbose16/android-sdk:30.0.3 /bin/bash
```
Now, build your project.
```bash
gradle clean assembleDebug
```
Done!
## Included stuffs
* OpenJDK "1.8.0_275"
* Android SDK Platform 30, Build-Tools 30.0.3
* Gradle 6.7.1
* curl 7.71.1
* Python 3.9.0
 
## Disclaimer
The Android SDK is a licensed software from Google. By using this container image, you agree to the terms and conditions of Android SDK.
