---
title: 'Cloud storage v2.0: the what and the how'
---

Cloud storage: we all use it, but how do you get to the next level with it? 
What do I mean by the next level? I mean hosting stuff that you can get direct URLs to, make them pretty as well, and embed this media anywhere you want.

## The easy and simple way: online free file hosting services
Here are some services that will make you happy in a couple of seconds:
### 1.1  Catbox.moe  (my personal favorite)
Catbox is an awesome file hosting service, where you can store your up to 200MB files indefinitely (or use Litterbox to use it temporarily).

It also provides a really neat API, which I use in my product [Interclip](https://blog.trnck.dev/what-is-interclip/)

[catbox.moe](https://catbox.moe/)


![Catbox logo](https://catbox.moe/pictures/logo.png)

### 1.2 Uguu.se
Although very similar in UI to Catbox, uguu.se is a temporary (24 hour) file hosting service with a 100MB file size limit.

[uguu.se](https://uguu.se/)


![uguu.se UI](https://trnck.dev/0:/img/eaa127e4-674b-4a8b-b6ab-9abf9ffcfe30.png)

### 1.3 File.io
File.io is a file hosting service only for temporary uploads, with a variable date of expiration. It also provides a really simple [API](https://www.file.io/#api)

[file.io](https://www.file.io/)

![file.io homepage](https://trnck.dev/0:/img/a02e952d-4669-4ddb-b917-928ef7dbb755.png)


##  The expensive way: the cloud
The services listed below are all on the enterprise level, where you pay for reads, writes, and other things. All of them are pay as you go.

### 2.1 Azure Blob Storage
The cloud storage option from Microsoft.

[Azure blob storage](https://azure.microsoft.com/en-us/services/storage/blobs/)

[Pricing](https://azure.microsoft.com/en-us/pricing/details/storage/blobs/)

![Azure Blob storage logo](https://trnck.dev/0:/img/blob.png)

### 2.2 GCP Storage Buckets
Google also provides a storage option on its Google Cloud Platform. It lacks a few features (like DragN'Drop), but it is a very good service used by a lot of big companies (including Kaggle, Twitter, and others).

[Google Cloud Storage options](https://cloud.google.com/storage)

[Pricing](https://cloud.google.com/storage#section-10)

![GCP Storage Bucket logo](https://trnck.dev/0:/img/google-cloud-storage.png)

### 2.**3** Amazon S**3**
The storage option from Amazon

[S3 details](https://aws.amazon.com/s3/)

[Pricing](https://aws.amazon.com/s3/pricing/?nc=sn&loc=4)

![S3 logo](https://trnck.dev/0:/img/s3.png)

### 2.4 Wasabi
If you want to pay less for an enterprise solution, you should try Wasabi. They say that they provide the same quality as all the three mentioned above in up to 80% less.

[Pricing calculator](https://wasabi.com/cloud-storage-pricing/#cost-calc)

[More info](https://wasabi.com/)

![Wasabi logo](https://trnck.dev/0:/img/wasabi.jpg)

## The hacky ways

### 3.1 Google Drive Direct links
If you want a quick and easy way to get direct media links, try [Google Drive Direct Media Links](https://sites.google.com/site/gdocs2direct/).

### 3.2 GoIndex
With a Google Drive and a Cloudflare account, you can have very cheap storage with unlimited bandwidth. You can get Google Drive storage for fairly low prices, and if you are in a company or a school with Gsuite, you may have an unlimited account.

![Pricing of Google One](https://trnck.dev/0:/img/cdcde6d2-8d00-4b98-8028-4c9c6ba52b45.png)

The only limitation is Cloudflare because [Cloudflare workers](https://workers.cloudflare.com/) provide only 100K free requests a day, but for most use cases, that's plenty.

You can achieve all this for free:


![Pricing of Google One](https://trnck.dev/0:/img/070e37e5-2901-4942-a267-c35f3e77fee8.png)


I will be posting a tutorial on how to do this later, but if you cannot wait, look at the [docs](https://github.com/alx-xlx/goindex).

Until then, see ya!
