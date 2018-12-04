FROM ejsohn/deep-env:latest

# Create workspace
ADD . /code/
RUN pip3 install -r /code/requirements.txt || true
WORKDIR /code