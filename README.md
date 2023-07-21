<!-- TABLE OF CONTENTS -->

# 📗 Table of Contents

- [📗 Table of Contents](#-table-of-contents)
- [📖 \[Send Messages API\] ](#-send-messages-api-)
  - [🛠 Built With ](#-built-with-)
    - [Tech Stack ](#tech-stack-)
    - [Links ](#links-)
    - [Key Features ](#key-features-)
  - [💻 Getting Started ](#-getting-started-)
    - [Prerequisites](#prerequisites)
    - [Setup](#setup)
    - [Install](#install)
    - [Usage](#usage)
    - [Test](#test)
  - [👥 Authors ](#-authors-)
  - [🔭 Future Features ](#-future-features-)
  - [🤝 Contributing ](#-contributing-)
  - [⭐️ Show your support ](#️-show-your-support-)
  - [❓ FAQ (OPTIONAL) ](#-faq-optional-)
  - [📝 License ](#-license-)

<!-- PROJECT DESCRIPTION -->

# 📖 [Send Messages API] <a name="about-project"></a>

The **Send Messages API** allows you to send SMS messages using two different providers. It employs a weighted approach to determine which provider to use for sending each message, offering redundancy in case one provider is down. Additionally, the API provides endpoints to check the status of a sent message and retrieve message details.

## 🛠 Built With <a name="built-with"></a>

### Tech Stack <a name="tech-stack"></a>

<details>
  <summary>Client</summary>
  <ul>
    <li><a href="https://rubyonrails.org/">Ruby on Rails</a></li>
  </ul>
</details>

<details>
  <summary>Server</summary>
  <ul>
    <li><a href="https://puma.io/">Puma</a></li>
    <li><a href="https://ngrok.com/">Ngrok</a></li>
  </ul>
</details>

<details>
<summary>Database</summary>
  <ul>
    <li><a href="https://www.postgresql.org/">PostgreSQL</a></li>
  </ul>
</details>

### Links <a name="links"></a>

[Live Demo]() - Under Construction

[Project Video](https://www.youtube.com/watch?v=WHG2QBK6DtE)

<!-- Features -->

### Key Features <a name="key-features"></a>

> The main goal of this app is to allow users / businesses send text messages to friends or customers.

- **[Distributes load via two SMS providers]**
- **[Check for message status to know if it is delivered or not]**
- **[Has data of invalid numbers to use as validation on UI so requests are not made to such numbers]**

<!-- GETTING STARTED -->

## 💻 Getting Started <a name="getting-started"></a>

To get a local copy up and running, follow these steps.

### Prerequisites

In order to run this project you need:

- to install Ngrok. Please follow [this](https://ngrok.com/download) link to have it installed.
- to have the latest version of [ruby on rails](https://guides.rubyonrails.org/) installed.
- to have a code editor on your computer.

### Setup

Clone [this](https://github.com/Haywayaheadshot/ror-texting-take-home) repository to your desired folder:

1- Navigate to the button on the top right green "code" button.

2- In the drop down menu choose "Download Zip" or clone it using git using the following command.

3- After extracting the files, you'll have my project on your local machine.

### Install

Install this project with:

- [$ bundle install]

### Usage

To run the project, execute the following command:

- [$ ./bin/dev] in one terminal.
- [$ ngrok http 3000 ] in another terminal.
- Copy forwarding link. It should look something like this "<https://e8cc-197-251-147-157.ngrok-free.app>"
   > Go to config/application.rb and replace the config.hosts code on line 30 with `config.hosts << "paste your ngrok link here"`
   > Go to app/dev/send_messages_controller.rb. Inside the provider_one method, replace callback_url value with `'https://paste your ngrok link here/delivery_status'`
   > Go to spec/requests/dev/send_messages_spec.rb. On line 6 change the value of url to `Your ngrok code`.

- Please read the [API Documentation](./API-Documentation.md) file to understand how to use the endpoints and their responses.

### Test

- [$ rspec]

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- AUTHORS -->

## 👥 Authors <a name="authors"></a>

 👤 **Abubakar Ummar**

- GitHub: [@Haywayaheadshot](https://github.com/Haywayaheadshot)
- LinkedIn: [@Abubakar Ummar](https://www.linkedin.com/in/abubakar-ummar/)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- FUTURE FEATURES -->

## 🔭 Future Features <a name="future-features"></a>
>
> I will create a UI that will allow users to:

- [ ] **Add their phone number, name, or email so the receiver can know who the message is from**
- [ ] **Get a notification that displays the status of the message**
- [ ] **Get a notifcation to try again when the status of messages is 500**

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTRIBUTING -->

## 🤝 Contributing <a name="contributing"></a>

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](../../issues/).

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- SUPPORT -->

## ⭐️ Show your support <a name="support"></a>

Anyone who finds this project interesting is welcome to give it a star.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- FAQ (optional) -->

## ❓ FAQ (OPTIONAL) <a name="faq"></a>

- **[How do i run the project in my local machine?]**

  - [You need to clone the project in your local environment through the terminal]

- **[What database are you using for this project?]**

  - [POSTGRESQL]

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- LICENSE -->

## 📝 License <a name="license"></a>

This project is [MIT](./LICENSE) licensed.

<p align="right">(<a href="#readme-top">back to top</a>)</p>
