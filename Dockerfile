FROM ubuntu
RUN mkdir /appfolder
COPY ./* /appfolder/
RUN echo "build successful"
