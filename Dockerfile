#
#   LEAN Docker Container 20200522
#   Cross platform deployment for multiple brokerages
#

# Use base system
FROM jmerle/lean:foundation-dotnet-5

MAINTAINER QuantConnect <contact@quantconnect.com>

#Install Python Tool for Visual Studio Debugger for remote python debugging
RUN pip install ptvsd

#Install PyDev Debugger for Pycharm for remote python debugging
RUN pip install pydevd-pycharm~=201.8538.36

# Install vsdbg for remote C# debugging in Visual Studio and Visual Studio Code
RUN wget https://aka.ms/getvsdbgsh -O - 2>/dev/null | /bin/sh /dev/stdin -v 16.9.20122.2 -l /root/vsdbg

COPY ./Launcher/bin/Debug/ /Lean/Launcher/bin/Debug/
COPY ./Optimizer.Launcher/bin/Debug/ /Lean/Optimizer.Launcher/bin/Debug/
COPY ./Report/bin/Debug/ /Lean/Report/bin/Debug/

# Can override with '-w'
WORKDIR /Lean/Launcher/bin/Debug

ENTRYPOINT [ "mono", "QuantConnect.Lean.Launcher.exe" ]
