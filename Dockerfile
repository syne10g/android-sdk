FROM ubuntu:18.04

ENV ANDROID_HOME /opt/android
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools

ADD start-default-emulator.sh /opt

RUN mkdir /opt/android

RUN apt update
RUN apt install openjdk-8-jdk wget unzip git -y
RUN chmod a+x /opt/start-default-emulator.sh
RUN wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip -qO android-sdk.zip
RUN unzip android-sdk.zip -d /opt/android
RUN rm android-sdk.zip
RUN echo "y" | sdkmanager "tools"
RUN echo "y" | sdkmanager "platform-tools"
RUN echo "y" | sdkmanager "build-tools;29.0.2"
RUN echo "y" | sdkmanager "extras;android;m2repository"
RUN echo "y" | sdkmanager "extras;google;m2repository"
RUN echo "y" | sdkmanager "emulator"
RUN echo "y" | sdkmanager "platforms;android-29"
RUN echo "y" | sdkmanager "system-images;android-29;google_apis;x86"
RUN echo "y" | sdkmanager --update
RUN echo "no" | avdmanager --verbose create avd --force --name emuone --device "5.4in FWVGA" --package "system-images;android-29;google_apis;x86" --tag "google_apis" --abi "x86"
RUN echo "no" | avdmanager --verbose create avd --force --name emutwo --device "5.4in FWVGA" --package "system-images;android-29;google_apis;x86" --tag "google_apis" --abi "x86"
RUN echo "no" | avdmanager --verbose create avd --force --name emuthree --device "5.4in FWVGA" --package "system-images;android-29;google_apis;x86" --tag "google_apis" --abi "x86"
RUN echo "no" | avdmanager --verbose create avd --force --name emufour --device "5.4in FWVGA" --package "system-images;android-29;google_apis;x86" --tag "google_apis" --abi "x86"

RUN rm -rf /var/lib/apt/lists/*
