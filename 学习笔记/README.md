# 我的具身智能学习笔记

课程来源：[Datawhale Every-Embodied](https://github.com/datawhalechina/every-embodied)。原课程署名与许可证保留在项目中。

本目录保存自己的理解、问题和练习记录。按课程章节创建 Markdown 文件，图片放在本目录的 `images/` 中。尽量通过相对链接引用课程原文，减少直接修改原教材带来的同步冲突。

## 学习记录

- [01 · 具身智能概述](./01-具身智能概述.md)

## 保存笔记

在项目根目录执行：

```bash
git add 学习笔记
git commit -m "notes: 更新学习笔记"
git push origin main
```

也可以直接让 Codex 将笔记提交到自己的 GitHub fork。命令行推送需要本机已完成 GitHub 身份验证。

## 更新原课程

先提交本地修改，确认 `git status --short` 没有输出，再执行：

```bash
git switch main
git fetch origin
git merge --ff-only origin/main
git fetch upstream
git merge --no-edit upstream/main
git push origin main
npm ci
npm run build:pages
```

`origin` 指向自己的 fork，`upstream` 指向 Datawhale 原仓库。合并会保留笔记历史；若提示冲突，先解决冲突再继续，不要用强制重置或强制推送代替合并。

重新构建后刷新本地阅读器即可看到更新。笔记会随 Markdown 目录扫描出现在本地阅读器中。公开 fork 中提交的笔记也会公开。
