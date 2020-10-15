# Android SDK Docker Images
This container image contains Android SDK 30.0.2. You can use this for building Android projects in your workstation, cloud or VCS pipelines.

## Usage

Pull the image from docker hub

```bash
docker pull anandbose16/android-sdk:30.0.2
```
Run the container with your project directory as a volume.

```bash
docker run -it --privileged -v /path/to/project:/project anandbose16/android-sdk:30.0.2 /bin/bash
```
Now, build your project.
```bash
gradle clean assembleDebug
```
Done!
## Included stuffs
* OpenJDK 1.8.0.252-2.2
* Android SDK Platform 30, Build-Tools 30.0.2
* Gradle 6.7
* curl 7.72.0-1.2
* Python 3.8.5
 
## Disclaimer
The Android SDK is a licensed software from Google. By using this container image, you agree to the terms and conditions of Android SDK.
