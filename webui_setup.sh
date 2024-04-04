#/usr/bin/env sh

$YOUR_HUGGINGFACE_TOKEN = "YOUR_HUGGINGFACE_TOKEN"

git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git
cd stable-diffusion-webui/models/Stable-diffusion/
curl -H "Authorization: Bearer ${YOUR_HUGGINGFACE_TOKEN}" https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/v1-5-pruned-emaonly.ckpt --location --output v1-5-pruned-emaonly.ckpt
conda create -n a1111-sdwebui python=3.10 -y
conda activate a1111-sdwebui
cd ../..
pip install -r requirements_versions.txt
conda install pytorch=1.13 torchvision=0.14 torchaudio=0.13 pytorch-cuda=11.7 -c pytorch -c nvidia -y
git config --global --add safe.directory '*'
pip install chardet
nohup accelerate launch --mixed_precision=fp16 --num_cpu_threads_per_process=8 launch.py --share --gradio-auth test:test > result.txt 2>&1