import io
import base64
from PIL import Image
import re


def img_to_base64_str(img):
    buffered = io.BytesIO()
    img.save(buffered, format="JPEG")
    buffered.seek(0)
    img_byte = buffered.getvalue()
    img_str = base64.b64encode(img_byte).decode()
    return img_str


def base64_to_image(base64_str, image_path=None):
    base64_data = re.sub('^data:image/.+;base64,', '', base64_str)
    byte_data = base64.b64decode(base64_data)
    image_data = io.BytesIO(byte_data)
    img = Image.open(image_data)
    if image_path:
        img.save(image_path)
    return img
