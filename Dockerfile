FROM alpine:3.8 AS downloader

LABEL maintainer="Jose Barahona jrab6692@gmail.com"

RUN apk --no-cache add wget

RUN wget --no-check-certificate https://github.com/squat/terraform-provider-vultr/releases/download/v0.1.9/terraform-provider-vultr_v0.1.9_linux_amd64.tar.gz

RUN tar xvzf terraform-provider-vultr_v0.1.9_linux_amd64.tar.gz

FROM hashicorp/terraform:0.11.11

WORKDIR /vultr/

COPY --from=downloader /terraform-provider-vultr_v0.1.9 ./.terraform/plugins/linux_amd64/

RUN terraform init
