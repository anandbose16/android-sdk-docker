# Setup base image
FROM fedora:33
RUN dnf update --refresh --assumeyes
RUN dnf install --assumeyes java-1.8.0-openjdk-devel curl python3-pycurl zip unzip git

# Setup environment
RUN mkdir -p /android
ENV JAVA_HOME="/usr/lib/jvm/java-1.8.0-openjdk"
ENV ANDROID_HOME="/android"
ENV GRADLE_HOME="${ANDROID_HOME}/gradle-6.8.1"
ENV PATH="${PATH}:${ANDROID_HOME}/build-tools/30.0.3:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/cmdline-tools/bin:${GRADLE_HOME}/bin"

# Install Android SDK commandline tools and Gradle
RUN curl 'https://dl.google.com/android/repository/commandlinetools-linux-6858069_latest.zip' -o $ANDROID_HOME/commandlinetools.zip
RUN unzip -qq $ANDROID_HOME/commandlinetools.zip -d $ANDROID_HOME
RUN curl 'https://downloads.gradle-dn.com/distributions/gradle-6.8.1-all.zip' -o "${ANDROID_HOME}/gradle-6.8.1-all.zip"
RUN unzip -qq "${ANDROID_HOME}/gradle-6.8.1-all.zip" -d $ANDROID_HOME

# Install Android SDK
RUN yes | sdkmanager --sdk_root=$ANDROID_HOME --install "build-tools;30.0.3" "platforms;android-30" "platform-tools"

# Accept licenses
RUN yes | sdkmanager --sdk_root=$ANDROID_HOME --licenses

# Cleanup
RUN dnf clean all
RUN rm "${ANDROID_HOME}/commandlinetools.zip" "${ANDROID_HOME}/gradle-6.8.1-all.zip"

# Entrypoint
ENTRYPOINT ["/bin/bash"]
