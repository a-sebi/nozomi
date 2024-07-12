{
  sshKeyPath,
  name,
  email,
  allowed_signers,
}: ''
  [user]
    name = ${name}
    email = ${email}
    signingkey = ${sshKeyPath}
  [pull]
    rebase = true
  [init]
    defaultBranch = main
  [filter "lfs"]
    process = git-lfs filter-process
    required = true
    clean = git-lfs clean -- %f
    smudge = git-lfs smudge -- %f
  [gpg]
    format = ssh
  [gpg "ssh"]
    allowedSignersFile = ${allowed_signers}
  [commit]
    gpgsign = true
''
