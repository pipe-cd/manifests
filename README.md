# Manifests

This repository contains all automatically generated release manifests for piped and control plane.

## Control Plane

- Using helm 3

``` consolse
helm install pipecd ./manifests/pipecd
```

- Using kubectl

``` consolse
TODO
```

## Piped

- Using helm 3

``` console
helm install piped-name ./manifests/piped \
    --set args.projectID=your-project-id \
    --set args.pipedID=your-piped-id \
    --set args.pipedKey=your-piped-key
```

- Using kubectl

``` consolse
TODO
```