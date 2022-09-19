from flask import Flask, Response, request,jsonify
import requests # to get image from the web
import shutil
app = Flask(__name__)
from google.cloud import automl_v1beta1
def get_prediction(content): # 'content' is base-64-encoded image data.
  prediction_client = automl_v1beta1.PredictionServiceClient()
  name = 'projects/utility-range-299820/locations/us-central1/models/ICN6871870707786055680'
  payload = {'image': {'image_bytes': content }}
  params = {}
  request = prediction_client.predict(name, payload, params)
  return request
@app.route('/', methods=['POST'])
def get_data():
    image_url = request.data.decode('UTF-8')
    filename = image_url.split("/")[-1]
    r = requests.get(image_url, stream=True) # Open the url image, set stream to True, this will return the stream content.
    if r.status_code == 200:  # Check if the image was retrieved successfully
        r.raw.decode_content = True # Set decode_content value to True, otherwise the downloaded image file's size will be zero.
        with open(filename, 'wb') as f:  # Open a local file with wb ( write binary ) permission.
            shutil.copyfileobj(r.raw, f)
        ff = open(filename, 'rb')
        content = ff.read()
        print(content)
        print('Image sucessfully Downloaded: ', filename)
    else:
        print('Image Couldn\'t be retreived')
    json_file = {}
    json_file['response'] = str(get_prediction(content))
    return jsonify(json_file)
if __name__ == '__main__':
    app.run(debug=True)

