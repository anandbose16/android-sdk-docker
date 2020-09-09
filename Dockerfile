FROM "docker.io/library/fedora:latest"
RUN mkdir -p /android
ENV ANDROID_HOME="/android"
ENV JAVA_HOME="/usr/lib/jvm/java-1.8.0"
ENV PATH="${PATH}:${ANDROID_HOME}/build-tools/30.0.2:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/tools/bin"
RUN dnf update --refresh --assumeyes
RUN dnf install java-1.8.0-openjdk-devel unzip python3-pycurl --assumeyes
RUN curl 'https://dl.google.com/android/repository/commandlinetools-linux-6609375_latest.zip' -o $ANDROID_HOME/commandlinetools.zip
RUN unzip -qq $ANDROID_HOME/commandlinetools.zip -d $ANDROID_HOME
RUN yes | sdkmanager --sdk_root=$ANDROID_HOME --install "build-tools;30.0.2" "platforms;android-30" "platform-tools"
RUN yes | sdkmanager --sdk_root=$ANDROID_HOME --licenses