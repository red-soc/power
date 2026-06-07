Welcome to the comprehensive course on Git! Whether you are an absolute beginner writing your first line of code or an experienced developer looking to master advanced workflows, this course is designed for you. 

We will break down Git from the ground up, turning complex concepts into simple, logical steps. Let’s dive in!

---

# 🎓 The Ultimate Git Mastery Course

## Module 1: The Foundations – What is Git?
Before typing a single command, you must understand what Git actually is. 

**Git is a Distributed Version Control System (DVCS).**
* **Version Control:** It tracks changes in your files over time, allowing you to recall specific versions later.
* **Distributed:** Every developer has a full copy of the entire repository history on their local machine, making it fast and allowing offline work.

### The Three States of Git
This is the most critical concept in Git. A file in Git resides in one of three areas:
1. **Working Directory:** The actual files on your computer that you are editing.
2. **Staging Area (Index):** A holding area. You tell Git which changes you want to include in the next commit.
3. **Repository (.git folder):** The database where Git permanently stores your committed snapshots.

---

## Module 2: Setup and Basic Workflows
Let’s get your machine ready and execute the core daily workflow.

### Configuration
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
git config --global init.defaultBranch main # Sets default branch name to 'main'
```

### The Daily Core Loop
1. **Initialize or Clone:**
   ```bash
   git init          # Start a new repository from scratch
   git clone <url>   # Download an existing repository
   ```
2. **Make Changes & Check Status:**
   ```bash
   git status        # See what has changed and what is staged/unstaged
   ```
3. **Stage Changes:**
   ```bash
   git add <file>    # Stage a specific file
   git add .         # Stage all changes in the directory
   ```
4. **Commit Changes:**
   ```bash
   git commit -m "Add feature X" # Save the snapshot permanently
   ```
5. **View History:**
   ```bash
   git log           # Full history
   git log --oneline # Condensed, one-commit-per-line history
   ```

### Ignoring Files (`.gitignore`)
Create a `.gitignore` file in your root directory. Add files you *never* want to track (e.g., `node_modules/`, `.env`, build outputs).

---

## Module 3: Branching & Merging – Git's Superpower
Think of branches as parallel universes. They allow you to work on features or fixes without affecting the main codebase.

### Branch Commands
```bash
git branch             # List all branches
git branch <name>      # Create a new branch
git switch <name>      # Move to a branch (modern command, replaces 'git checkout <branch>')
git switch -c <name>   # Create AND switch to a new branch in one step
git branch -d <name>   # Delete a branch (safe delete, won't delete if unmerged)
```

### Merging
Once your feature is done, you merge it back into your main branch.
```bash
git switch main        # Go to the target branch
git merge <feature>    # Merge the feature branch into main
```

### Dealing with Merge Conflicts
Sometimes, Git doesn't know how to automatically combine changes (e.g., two people edited the same line). This is a **Merge Conflict**.
1. Git will mark the file with conflict markers: `<<<<<<<`, `=======`, `>>>>>>>`
2. Open the file, manually edit it to look how you want, and remove the markers.
3. Stage the resolved file (`git add <file>`) and commit (`git commit`).

---

## Module 4: Remote Collaboration
Git lives on your computer (Local), but you need a server (Remote) like GitHub, GitLab, or Bitbucket to collaborate.

### Remote Commands
```bash
git remote -v                          # List connected remotes
git remote add origin <url>            # Link a local repo to a remote one
git push -u origin main                # Upload local commits to remote (the -u sets the upstream tracking branch)
git push                               # Subsequent pushes are simpler
git pull                               # Download remote changes AND merge them into your local branch
git fetch                              # Download remote changes WITHOUT merging (safer, lets you review first)
```

---

## Module 5: Intermediate Power Moves
Mistakes happen. Git has tools to fix them.

### 1. Stashing
Need to switch branches but aren't ready to commit? Put your changes in a sticky note.
```bash
git stash          # Save current uncommitted changes
git stash list     # View all stashes
git stash pop      # Apply the most recent stash and delete it
git stash apply    # Apply the most recent stash but keep it in the list
```

### 2. Fixing your last commit
Forgot a file or made a typo in the message?
```bash
git add <forgotten_file>
git commit --amend -m "New correct message"
```
*⚠️ Warning: Never amend commits that you have already pushed to a shared remote!*

### 3. Reset vs. Revert (Undoing Commits)
* **`git revert <hash>`**: Creates a *new* commit that undoes the changes of a previous commit. **Safe for shared branches.**
* **`git reset <hash>`**: Moves the branch pointer backward, erasing history. 
   * `git reset --soft <hash>`: Undoes commits, but keeps changes in the Staging Area.
   * `git reset --mixed <hash>`: Undoes commits, keeps changes in the Working Directory.
   * `git reset --hard <hash>`: Destroys the commits and all changes permanently.

---

## Module 6: Advanced Git
Time to go from user to master.

### 1. Rebase
Rebasing is an alternative to merging. It takes your commits and "replays" them on top of another branch, creating a linear, clean history.
```bash
git switch feature
git rebase main
```
*⚠️ The Golden Rule of Rebase: Never rebase commits that have been pushed to a public repository. It rewrites history and will ruin your teammates' local repos.*

### 2. Interactive Rebase
The ultimate history-cleanup tool.
```bash
git rebase -i HEAD~3 # Interactively edit the last 3 commits
```
This opens an editor where you can choose to:
* **Squash:** Combine multiple commits into one.
* **Reword:** Change a commit message.
* **Drop:** Delete a commit entirely.

### 3. Reflog (The Safety Net)
If you accidentally `reset --hard` and lose commits, don't panic! Git keeps a log of every time a branch tip moves.
```bash
git reflog
# Find the hash of the commit you lost
git reset --hard <hash> # Restore it!
```

### 4. Cherry-Pick
Want a specific commit from another branch without merging the whole thing?
```bash
git cherry-pick <commit-hash>
```

---

## Module 7: Workflows & Best Practices
How teams use Git effectively.

### Branching Strategies
1. **GitHub Flow (Simple, best for continuous deployment):**
   * `main` is always deployable.
   * Create a branch for a feature/fix.
   * Commit, push, and open a Pull Request.
   * Merge to `main` and deploy.
2. **GitFlow (Complex, best for scheduled releases):**
   * Uses `main` (production), `develop` (integration), `feature/*`, `release/*`, and `hotfix/*` branches.

### Commit Message Best Practices (Conventional Commits)
Write messages that are useful to your future self and teammates.
* **Format:** `<type>: <subject>`
* **Types:** `feat:` (new feature), `fix:` (bug fix), `docs:` (documentation), `refactor:` (code cleanup), `chore:` (maintenance).
* *Example:* `feat: add user authentication API`
* Keep the subject line under 50 characters. Use the body to explain *why*, not *what* (Git can show the `diff` for *what*).

### Pull Requests (PRs) / Merge Requests (MRs)
Do not merge your own code blindly. PRs are a conversation. They allow for code review, automated testing, and knowledge sharing before code hits the main branch.

---

## Module 8: Troubleshooting & Pro Tips

### "I committed to the wrong branch!"
```bash
git reset --soft HEAD~1  # Undo the commit but keep changes staged
git stash                # Stash the changes
git switch correct_branch# Go to the right branch
git stash pop            # Apply the changes
git commit -m "My changes" # Commit again
```

### "I need to unstage a file (remove from `git add`)"
```bash
git restore --staged <file> # (Modern command)
```

### Git Aliases
Speed up your workflow by adding shortcuts to your `.gitconfig`:
```bash
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.lg "log --oneline --graph --all"
```
Now you can just type `git co main` instead of `git checkout main`.

### GUIs vs. CLI
While the Command Line Interface (CLI) is essential for understanding Git deeply and fixing tricky issues, Graphical User Interfaces (GUIs) are fantastic for daily visual work. Popular choices include **GitKraken**, **Sourcetree**, and the built-in Git features in **VS Code**.

---

## 🏆 Final Exam/Practice Project
To cement your knowledge, do the following:
1. Create a new repo on GitHub. Clone it locally.
2. Create a `feature/text` branch.
3. Add a file called `story.txt` with a sentence. Commit it.
4. Switch back to `main`. Add a `README.md` file and commit it.
5. Merge `feature/text` into `main`.
6. Push to GitHub.
7. Intentionally create a merge conflict and resolve it.
8. Use `git reset` to undo a commit, then use `reflog` to get it back.

*Congratulations! You are no longer just using Git; you understand it.*
