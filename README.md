# NVIDIA-PACKER-DOCKER-ANSIBLE

packer, ansible, nvidia-docker를 사용한 자동 딥러닝 개발환경 생성 예제입니다.

packer 명령어로 딥러닝에 사용될 nvidia-docker 이미지가 설치된 AWS AMI를 생성합니다.

## Quick Start

다음의 준비물이 필요합니다.
* packer
* aws
    * access_key
    * scret_key
    * subnet_id
    * vpc_id

root 디렉토리에서 다음의 명령어를 쳐주세요

```
packer build \
    -var 'subnet_id=subnet-9be79cd7' \ # these are dummy values
    -var 'vpc_id=vpc-c3d83da8' \
    -var 'aws_access_key=AKIAINYA3F5XNCXKSCOA' \
    -var 'aws_secret_key=kyeqnlrvAH0goHSZRD9Sut0f5nCRDKWL7o2leGif' gpu-packer.json

```

AMI가 생성될 때까지 기다린 후, AWS Console에 들어가 해당 AMI로 EC2를 구동합니다. gpu 지원이 되는 p2, p3 family가 필요합니다.

EC2가 준비되면 ssh로 접근해주세요. 그리고 이제 docker를 구동해 작업을 하면 됩니다

```
ssh -i key.pem ubuntu@ip

nvidia-docker run -it -p 8000:8000 deep-env /bin/bash
```


