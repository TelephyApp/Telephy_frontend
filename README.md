## telephyfrontend

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


# How to Setup

**Step 1:**

Download or clone this repo by using the link below:

```
https://github.com/TelephyApp/Telephy_frontend.git
```


**Step 2:**

Go to project root and execute the following command in console to get the required dependencies:

```
flutter pub get
```

# Githup Workflow
**First of all, Never ever dev on main branch!!**

*Work on  branch*
1. create new branch for your new feature
   ``` git branch <branch_name> ```
2. checkout into your branch 
   ``` git checkout <branch_name> ```
3. dev with fire!

*Add and Commit*
1. Add you change file
   ``` git add -A ```
   this means adding all changed files.
2. Commit
   ``` git commit -m "<comments_here_must_have>" ```

*Push and Pull*
Before pushing your commit into Github, I would highly recommend you to pull main branch into your branch first
to reduce conflict when merging into main, then solve the conflict in your branch before pushing into main branch

1. make sure you are now in your branch
2. then fetch main branch
   ```git fetch origin main```
3. pull main into your branch
   ```git pull origin main```
4. this might cause conflict, solve it!
5. then add and commit your conflict solved
*6. then push your branch into main*
   ```git push```
7. go to GitHub Page and click Pull Request
8. Done, wait for DevOps(fair) to merge it!
