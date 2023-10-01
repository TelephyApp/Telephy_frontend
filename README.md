# telephyfrontend

# How to Setup

**Step 1:**

Download or clone this repo by using the link below:

```
https://github.com/TelephyApp/Telephy_frontend.git
```


**Step 2:**

Go to the project root and execute the following command in the console to get the required dependencies:

```
flutter pub get
```


# GitHub Workflow

**1. Never Develop on the Main Branch!**

**2. Create a New Feature Branch**

- Create a new branch for your new feature:
   ```bash
   git checkout -b <branch_name>
   ```
   Replace `<branch_name>` with a descriptive name for your feature.

**3. Develop Your Feature**

- Make your changes and commit them as needed. Use meaningful commit messages:
   ```bash
   git add -A
   git commit -m "Your meaningful commit message here"
   ```

**4. Stay Updated with the Main Branch**

- Before pushing your changes, it's essential to keep your feature branch up-to-date with the main branch. This helps prevent conflicts when merging.
   ```bash
   # Ensure you are on your feature branch
   git checkout <branch_name>

   # Fetch the latest changes from the main branch
   git fetch origin main

   # Merge the latest changes from the main branch into your feature branch
   git merge origin/main
   ```

   If there are conflicts, resolve them in your feature branch. After resolving conflicts, add and commit the changes.

**5. Push Your Feature Branch**

- Once you've resolved conflicts (if any), push your feature branch to GitHub:
   ```bash
   git push origin <branch_name>
   ```

**6. Create a Pull Request**

- Go to the GitHub repository's page and click on "Pull Request."
- Compare your feature branch to the main branch.
- Provide a descriptive title and details for your pull request. Include any relevant context and information for reviewers.
- Reviewers will assess your changes and may request additional modifications.
- Make further commits and push changes if needed based on the feedback.

**7. Merge Your Pull Request**

- After your pull request is approved, merge it into the main branch.
- You can either merge it directly on GitHub or use the command line:
   ```bash
   # Ensure you are on your feature branch
   git checkout <branch_name>

   # Merge your feature branch into the main branch
   git merge origin/main

   # Push the merged changes to the main branch
   git push origin main
   ```

**8. Delete Your Feature Branch**

- After your pull request is merged and your feature is complete, you can delete your feature branch to keep the repository clean:
   ```bash
   git branch -d <branch_name>
   ```
