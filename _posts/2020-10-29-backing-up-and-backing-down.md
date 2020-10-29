---
title: Backing up & backing down
---

Hello, today's blog post is all about backing up stuff to the cloud and also having copies at home locally. Doing this is very important since it is crucial to keep your data alive even when something bad happens. To do all of this, we will be using [rclone](https://rclone.org/), which is an awesome open-source tool for doing stuff with cloud storage.

You can use rclone with all of these services, the process will be very similar to the one I will be using (Google Drive & Google Photos):

![Picture of table](https://trnck.dev/0:/img/7e5d5c64-3155-4cbb-9782-2649969908c2.png)

## Setup
### Install rclone
First, install rclone, this is fairly easy:
* On Linux based systems, execute `curl https://rclone.org/install.sh | sudo bash`
* On Windows, download with Chocolatey (`choco install rclone`) or download it from their [Downloads](https://rclone.org/downloads/) page
* On macOS, use `brew install rclone` with Homebrew or also head to their [Downloads](https://rclone.org/downloads/) page for the installer

### Configuring rclone
Keep in mind, I will be setting up Google Drive in this example, but other apps are set up similarly.
1. Open the terminal, and in your shell execute `rclone config` <br>
![Picture of output](https://trnck.dev/0:/img/3ab6781d-566a-4f5e-a618-6958d0cb06c7.png)
2. Choose the option `n` for a new remote 
3. Choose a simple name (can be anything you want) <br>
4. Fill in the number corresponding to the storage option you want to use (this is remote)
![Picture of output](https://trnck.dev/0:/img/26104b81-0495-42e4-a1d7-741440994d8d.png)
5. If prompted for any platform-specific details, fill them out, but for Google services, you don't have to fill in the Client ID and the Client secret.
6. Grant full access <br>
![Picture of output](https://trnck.dev/0:/img/f171e556-b416-4f75-8cb2-02c473f2b432.png)
7. Enter the ID of the root folder, this can be nothing, or the end part of the URL when browsing your Drive.
8. Leave the service account field empty
9. Skip through the next 2 steps with the Enter key
10. You will then be prompted to sign in with your default browser <br>
![Auth](https://trnck.dev/0:/img/a13047c6-6829-4754-8301-7b7b8c04c3a0.png)
11. Grant access to the requested resources <br>
![Auth](https://trnck.dev/0:/img/542ff7b7-10b6-4ed6-aef1-ecdbbd56c7df.png)
12. Select `n` to not configure as a team drive
13.  You are done!

### Downloading and uploading
An example use case (which I use) is backing up my stuff from my computer to Google Drive, that command would like like this:
```sh
rclone copy --update --verbose --transfers 25 --checkers 8 --contimeout 60s --timeout 300s --retries 3 --low-level-retries 10 --stats 1s "/mnt/c/directory" remote:
```

To download from the remote (for example to keep a copy of all your Google Photos or Onedrive documents locally), just switch out the remote and the source path

**Thanks for reading!**
