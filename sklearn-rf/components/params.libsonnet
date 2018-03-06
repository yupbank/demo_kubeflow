{
  global: {
    // User-defined global parameters; accessible to all component and environments, Ex:
    // replicas: 4,
  },
  components: {
    // Component-level parameters, defined initially from 'ks prototype use ...'
    // Each object below should correspond to a component in the components/ directory
    "sklearn-rf": {
      http_proxy_image: "gcr.io/shopify-codelab-and-demos/http-proxy:1.6",
      model_path: "gs://pengyu-ml-test/sklearn-rf",
      model_server_image: "gcr.io/kubeflow/model-server:1.0",
      name: "sklearn-rf",
      namespace: "default",
      service_type: "ClusterIP",
    },
  },
}
