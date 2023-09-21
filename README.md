## telephyfrontend

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

**Work on  branch**
1. create new branch for your new feature
   ```
   git branch <branch_name>
   ```
3. checkout into your branch 
   ```
   git checkout <branch_name>
   ```
5. dev with fire!

**Add and Commit**
1. Add you change file
   ```
   git add -A
   ```
   this means adding all changed files.
3. Commit
   ```
   git commit -m "<comments_here_must_have>"
   ```

**Push and Pull** <br/>

Before pushing your commit into Github, I would highly recommend you to pull main branch into your branch first
to reduce conflict when merging into main, then solve the conflict in your branch before pushing into main branch

1. make sure you are now in your branch <br/>
2. then fetch main branch <br/>
   ```
   git fetch origin main
   ```
4. pull main into your branch <br/>
   ```
   git pull origin main
   ```
6. this might cause conflict, solve it! <br/>
7. then add and commit your conflict solved <br/>
8. then push your branch into main 
   ```
   git push
   ```
10. go to GitHub Page and click Pull Request <br/>
11. Done, wait for DevOps(fair) to merge it! <br/>
