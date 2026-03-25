# `$careful`

Source: `gstack`

## Purpose

在执行破坏性命令前增加安全提示，降低误删、误强推或误删资源的风险。

## Preconditions

- 即将执行高风险命令，例如 `rm -rf`、`git reset --hard`、`DROP TABLE`、强推或删除资源。

## Inputs / Source Of Truth

- 即将执行的命令

## Produces / Writes

- 安全警告
- 用户确认后的继续或取消决策

## Execution Flow

1. 识别命令中的破坏性模式。
2. 在真正执行前发出警告。
3. 让用户确认是继续还是取消。

## Stops / Failure Modes

- 无；它本身就是保护层，不承担业务执行。

## Next Recommended Steps

- 如需再限制编辑范围，进入 `$freeze` 或 `$guard`
