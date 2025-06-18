# 🌦️ Weather Forecast App (Deployed with Terraform & AWS)

## 📌 Project Overview

This project is a **fully automated Weather Forecast Web App** that displays real-time and 5-day weather data using the OpenWeatherMap API. It's built with a simple frontend and deployed entirely on **AWS using Terraform**

## 🌐 AWS Architecture Overview
The frontend of the weather app is hosted on an S3 bucket and served securely via CloudFront CDN. When a user searches for a city, the frontend makes a request to an API Gateway URL. This triggers an AWS Lambda function that fetches live weather and forecast data from the OpenWeatherMap API. The Lambda function returns the data as a JSON response, which is displayed on the web page using JavaScript. All infrastructure (S3, CloudFront, Lambda, API Gateway, IAM roles) is provisioned automatically using Terraform. This setup ensures a fully serverless, scalable, and cost-effective architecture.

---

## 🛠️ AWS Resources Used

- **Amazon S3** – static website hosting
- **AWS Lambda** – fetch weather data from OpenWeatherMap
- **API Gateway** – expose Lambda as HTTP endpoint
- **CloudFront** – CDN for faster frontend delivery
- **IAM Roles** – secure permissions
- **Terraform** – infrastructure as code

---

## 🧩 Problems Faced & Solved

- ❌ Weather API key not loading in Lambda → ✅ Fixed by setting `WEATHER_API_KEY` in environment variables
- ❌ API worked in terminal but not Lambda → ✅ Corrected `https` usage in Node.js code
- ❌ Accidentally pushed sensitive API key → ✅ Solved using `.gitignore` and `terraform.tfvars.example`
- ✅ Automated everything using Terraform — no manual clicks!
  

---
## 🚀 How to Try This Project

## ✅ Prerequisites

Install the following before you begin:

- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- [Node.js and npm](https://nodejs.org/)
- AWS Account with programmatic access and IAM permissions
- [OpenWeatherMap API Key](https://home.openweathermap.org/api_keys)

---
## step 1: Clone the Repository
```bash
git clone https://github.com/yourusername/weatherapp-terraform.git
cd weatherapp-terraform
```
---

## 🔐 Step 2: Create Terraform Variables File

In the `weatherApp-terraform/` folder, create a `terraform.tfvars` file:

```bash
touch terraform.tfvars
```

Add the following content (use your own values):

```hcl
region           = "ap-northeast-1"
bucket_name      = "weather-app-static-site-demo"
lambda_name      = "weatherAPIHandler"
lambda_zip_path  = "lambda/weather-api.zip"
weather_api_key  = "your_openweathermap_api_key_here"
```
🔐 Get Your OpenWeatherMap API Key:
- Go to OpenWeatherMap API Keys
- Sign up or log in
- Copy your API key and paste it in terraform.tfvars like:

> ⚠️ `terraform.tfvars` is git-ignored for safety. Provide a `terraform.tfvars.example` file in your repo for user guidance.

---

## 📦 Step 3: Prepare the Lambda Function

From the `weatherApp-terraform/lambda/` folder:

```bash
cd lambda
npm install
zip -r weather-api.zip index.js node_modules
mv weather-api.zip ../lambda/
cd ..
```

---

## 🚀 Step 4: Deploy Infrastructure using Terraform

```bash
terraform init
terraform plan
terraform apply -auto-approve
```

✅ After successful apply, you’ll see output variables like::

- api_gateway_url
- cloudfront_domain
- s3_website_url
  

---
## Inject the API Gateway URL into `weather.js`:
Go to the project root where the inject_api_url.sh file is present, then run:
```bash
chmod +x inject_api_url.sh
./inject_api_url.sh <API_GATEWAY_URL>
```
Example:
```bash
./inject_api_url.sh https://jn06lx9k9d.execute-api.ap-northeast-1.amazonaws.com
```
🔐 Make sure you run this after Terraform apply, when you know your API Gateway URL.

---
## Step 5: Sync the Updated Frontend to S3
``` bash
aws s3 sync ../weatherApp s3://your-bucket-name --delete
```
Replace your-bucket-name with your actual bucket name from terraform.tfvars.

---
## 🌐 Step 6: Access the Application

After apply is complete, Terraform will output:

- ✅ **CloudFront URL** — use this to open your weather app
- ✅ **API Gateway URL**

---

## 🧪 Step 7: Visit Your App

Open the **CloudFront URL** in your browser. You should see:
```bash
https://<your-cloudfront-domain>
```
- City autocomplete search bar
- Weather cards
- 5-day forecast chart
- Toast notifications and loading spinner

---

## 🧼 Step 8: Cleanup

Destroy infrastructure when you're done to avoid charges:

```bash
terraform destroy -auto-approve
```

---
## 📌 To-Do List
- Add CI/CD pipeline using GitHub Actions
- Monitor Lambda/API Gateway usage
- Add Ansible provisioner for extended setup
- Notify on errors using AWS SNS or email
---

## 💡 Note
This project is built to demonstrate how to:
- Use Infrastructure as Code
- Automate provisioning of serverless components
- Securely integrate 3rd party APIs
- Provide reusable, portable projects for othersf you like this project, a ⭐️ on GitHub is appreciated! Feel free to fork, contribute, or connect with me.




