## Install the requirements
```
pip install -r requirements.txt
```

## Export Model to the cloud

```
python demo.py --output_dir gs://pengyu-ml-test/sklearn-rf
```
We also output two examples to query
```
0 0
{"instances": [{"features": [-1.6685316562652588, -1.2990134954452515, 0.27464720606803894, -0.6036204099655151]}, {"features": [-2.9728827476501465, -1.0887829065322876, 0.7088595628738403, 0.4228185713291168]}]}
```

## Init using ksonnet
```
ks init sklearn-rf
cd sklearn-rf
ks registry add kubeflow github.com/kubeflow/kubeflow/tree/master/kubeflow
ks pkg install kubeflow/tf-serving
ks env add  cloud
MODEL_COMPONENT=sklearn-rf
MODEL_NAME=sklearn-rf
MODEL_PATH=gs://pengyu-ml-test/sklearn-rf
MODEL_SERVER_IMAGE=gcr.io/kubeflow/model-server:1.0
HTTP_PROXY_IMAGE=gcr.io/shopify-codelab-and-demos/http-proxy:1.6
ks generate tf-serving ${MODEL_COMPONENT} --name=${MODEL_NAME} --namespace=default --model_path=${MODEL_PATH} --model_server_image=${MODEL_SERVER_IMAGE} --http_proxy_image=${HTTP_PROXY_IMAGE}
ks apply cloud -c ${MODEL_COMPONENT}
kubectl get services
```

## Test the result
```
curl -X POST -H "Content-Type: application/json" -d '{"instances": [{"features": [-1.6685316562652588, -1.2990134954452515, 0.27464720606803894, -0.6036204099655151]}, {"features": [-2.9728827476501465, -1.0887829065322876, 0.7088595628738403, 0.4228185713291168]}]}' 35.202.140.39:8000/model/sklearn-rf:classify
```
Get Predicted

```
{"result": {"classifications": [{"classes": [{"score": 0.9999990463256836, "label": "0"}, {"score": 9.999988606068655e-07, "label": "1"}]}, {"classes": [{"score": 0.8999999761581421, "label": "0"}, {"score": 0.09999999403953552, "label": "1"}]}]}}
```
