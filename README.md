# Android SDK Docker Images
This container image contains Android SDK 30.0.2. You can use this for building Android projects in your workstation, cloud or VCS pipelines.

## Usage

Pull the image from docker hub

```bash
docker pull anandbose16/android-sdk:30.0.2
```
Run the container with your project directory as a volume.

```bash
docker run -it -v /path/to/project:/project anandbose16/android-sdk:30.0.2 /bin/bash
```
Now, build your project.
```bash
gradle clean assembleDebug
```
Done!
## Included stuffs
* OpenJDK 1.8.0_272 (IcedTea 25.272-b10)
* Android SDK Platform 30, Build-Tools 30.0.2
* Gradle 6.7.1
* curl 7.73.0
* Python 3.8.6
 
## Disclaimer
The Android SDK is a licensed software from Google. By using this container image, you agree to the terms and conditions of Android SDK.
