# opencv-dockerfile
dockerfile for opencv dev image 

docker run --rm -it --mount type=bind,src=$PWD/KF-EBT/,dst=/KF-EBT --mount type=bind,src=$PWD/vot-toolkit,dst=/vot-toolkit --mount type=bind,src=$PWD/workspace,dst=/workspace psenna/opencv bash
