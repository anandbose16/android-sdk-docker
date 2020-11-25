# Setup base image
FROM "docker.io/opensuse/tumbleweed:latest"
RUN zypper clean --all && zypper dup --allow-vendor-change --no-confirm
RUN zypper install --no-confirm java-1_8_0-openjdk-devel curl python3-pycurl unzip git
RUN update-alternatives --set java /usr/lib64/jvm/jre-1.8.0-openjdk/bin/java

# Setup environment
RUN mkdir -p /android
ENV JAVA_HOME="/usr/lib64/jvm/jre-1.8.0-openjdk"
ENV ANDROID_HOME="/android"
ENV GRADLE_HOME="${ANDROID_HOME}/gradle-6.7"
ENV PATH="${PATH}:${ANDROID_HOME}/build-tools/30.0.2:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/tools/bin:${GRADLE_HOME}/bin"

# Install Android SDK commandline tools and Gradle
RUN curl 'https://dl.google.com/android/repository/commandlinetools-linux-6609375_latest.zip' -o $ANDROID_HOME/commandlinetools.zip
RUN unzip -qq $ANDROID_HOME/commandlinetools.zip -d $ANDROID_HOME
RUN curl 'https://downloads.gradle-dn.com/distributions/gradle-6.7-all.zip' -o $ANDROID_HOME/gradle-6.7-all.zip
RUN unzip -qq $ANDROID_HOME/gradle-6.7-all.zip -d $ANDROID_HOME

# Install Android SDK
RUN yes | sdkmanager --sdk_root=$ANDROID_HOME --install "build-tools;30.0.2" "platforms;android-30" "platform-tools"

# Accept licenses
RUN yes | sdkmanager --sdk_root=$ANDROID_HOME --licenses

# Cleanup
RUN zypper clean --all
RUN rm $ANDROID_HOME/commandlinetools.zip $ANDROID_HOME/gradle-6.7-all.zip
