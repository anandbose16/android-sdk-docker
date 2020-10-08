FROM "docker.io/opensuse/tumbleweed:latest"
RUN mkdir -p /android
ENV JAVA_HOME="/usr/lib64/jvm/jre-1.8.0-openjdk"
ENV ANDROID_HOME="/android"
ENV GRADLE_HOME="${ANDROID_HOME}/gradle-6.6.1"
ENV PATH="${PATH}:${ANDROID_HOME}/build-tools/30.0.2:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/tools/bin:${GRADLE_HOME}/bin"
RUN zypper clean --all && zypper up --no-confirm
RUN zypper install --no-confirm java-1_8_0-openjdk-devel curl python3-pycurl unzip git
RUN update-alternatives --set java /usr/lib64/jvm/jre-1.8.0-openjdk/bin/java
RUN curl 'https://dl.google.com/android/repository/commandlinetools-linux-6609375_latest.zip' -o $ANDROID_HOME/commandlinetools.zip
RUN unzip -qq $ANDROID_HOME/commandlinetools.zip -d $ANDROID_HOME
RUN curl 'https://downloads.gradle-dn.com/distributions/gradle-6.6.1-all.zip' -o $ANDROID_HOME/gradle-6.6.1-all.zip
RUN unzip -qq $ANDROID_HOME/gradle-6.6.1-all.zip -d $ANDROID_HOME
RUN rm $ANDROID_HOME/commandlinetools.zip $ANDROID_HOME/gradle-6.6.1-all.zip
RUN yes | sdkmanager --sdk_root=$ANDROID_HOME --install "build-tools;30.0.2" "platforms;android-30" "platform-tools" "tools"
RUN yes | sdkmanager --sdk_root=$ANDROID_HOME --licenses
