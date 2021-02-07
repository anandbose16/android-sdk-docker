# Setup base image for build
FROM fedora:33 as build
RUN dnf update --refresh --assumeyes
RUN dnf install --assumeyes java-1.8.0-openjdk-devel curl zip unzip

# Setup environment
RUN mkdir -p /android
ENV JAVA_HOME="/usr/lib/jvm/java-1.8.0-openjdk" \
    ANDROID_HOME="/android" \
    GRADLE_HOME="/android/gradle-6.8.1"
ENV PATH="${PATH}:${ANDROID_HOME}/build-tools/30.0.3:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/cmdline-tools/bin:${GRADLE_HOME}/bin"

# Install Android SDK commandline tools and Gradle
RUN curl 'https://dl.google.com/android/repository/commandlinetools-linux-6858069_latest.zip' -o $ANDROID_HOME/commandlinetools.zip
RUN unzip -qq $ANDROID_HOME/commandlinetools.zip -d $ANDROID_HOME
RUN curl 'https://downloads.gradle-dn.com/distributions/gradle-6.8.1-all.zip' -o "${ANDROID_HOME}/gradle.zip"
RUN unzip -qq "${ANDROID_HOME}/gradle.zip" -d $ANDROID_HOME

# Install Android SDK
RUN yes | sdkmanager --sdk_root=$ANDROID_HOME --install "build-tools;30.0.3" "platforms;android-30"

# Accept licenses
RUN yes | sdkmanager --sdk_root=$ANDROID_HOME --licenses

# Cleanup
RUN dnf clean all
RUN rm "${ANDROID_HOME}/commandlinetools.zip" "${ANDROID_HOME}/gradle.zip"

# Setup base image for production
FROM fedora:33

RUN dnf update --refresh --assumeyes && dnf install --assumeyes java-1.8.0-openjdk-devel curl python3-pycurl zip unzip git

COPY --from=build /android /android

ENV JAVA_HOME="/usr/lib/jvm/java-1.8.0-openjdk" \
    ANDROID_HOME="/android" \
    GRADLE_HOME="/android/gradle-6.8.1"

ENV PATH="${PATH}:${ANDROID_HOME}/build-tools/30.0.3:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/cmdline-tools/bin:${GRADLE_HOME}/bin"

# Entrypoint
ENTRYPOINT ["/bin/bash"]