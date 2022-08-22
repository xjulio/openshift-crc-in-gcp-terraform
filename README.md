# openshift-crc-in-gcp-terraform
Terraform project to deploy RedHat OpenShift CRC - Code Ready Containers in Google Cloud Platform (GCP).

CodeReady Containers (CRC) brings a minimal, preconfigured OpenShift 4.1 or newer cluster to your local laptop, desktop computer or cloud instance for development and testing purposes. CodeReady Containers is delivered as a Red Hat Enterprise Linux virtual machine that supports native hypervisors for Linux, macOS, and Windows 10.

CodeReady Containers requires the following minimum system resources:

* 4 virtual CPUs (vCPUs)
* 9 GB of free memory
* 35 GB of storage space

If you don't have these resources available, then using a cloud provider which supports nested virtualization (required by CRC) it's a good option. 

GCP offers nested virtualization setting `true` to `enable-nested-virtualization` instance configuration. AWS only supports nested virtualization in bare metal instance$, extremely expensive.

## Requirements
* Google Cloud Account
    - New customers get $300 in free credits to run, test, and deploy workloads
* Google Cloud Sdk installed
    - https://cloud.google.com/sdk/docs/install
* RedHat Account
    - https://sso.redhat.com/
* Terraform version >= v1.2.0
    - https://www.terraform.io/downloads
* OpenShift CodeReady WorkSpaces pull secret
    - https://console.redhat.com/openshift/create/local


## Steps
### 1 - Login in GCP

```
gcloud auth application-default login
```

### 2 - Clone git repo
```
git clone https://github.com/xjulio/openshift-crc-in-gcp-terraform.git
```

### 3 - Initialize terraform
```
cd openshift-crc-in-gcp-terraform
terraform init
```

### 4 - Create the terraform plan
```
terraform plan
```

### 5 - Apply the terraform plan
```
terraform apply
```

### 6 - Connect the crc instance
Wait for terraform to apply and isntance boot, then connect using `gcloud` command.
```
gcloud compute ssh crc
```

### 7 - Install crc
```
sh /tmp/crc-setup.sh
```

After the installation process is complete CRC will provide the commands to login into OpenShift.
