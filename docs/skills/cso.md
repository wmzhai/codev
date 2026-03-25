# `$cso`

Source: `gstack`

## Purpose

做基础设施优先的安全审查，覆盖供应链、CI/CD、OWASP Top 10、STRIDE、LLM/AI 边界和 secrets 风险。

## Preconditions

- 用户明确要求安全审计，或当前任务风险较高。
- 允许读取代码、配置、依赖和 CI/CD 设置。

## Inputs / Source Of Truth

- 当前代码与依赖
- CI/CD 配置
- Secrets 与部署配置
- 认证、授权和 LLM 信任边界

## Produces / Writes

- 安全 findings
- 风险等级、利用场景和缓解建议

## Execution Flow

1. 盘点依赖、凭证、配置和部署链路。
2. 从供应链、OWASP、STRIDE 与 AI 边界等维度做系统审查。
3. 验证高风险 finding 的可信度，降低误报。
4. 输出安全报告和后续修复建议。

## Stops / Failure Modes

- 关键配置不可读，无法完成可信判断。
- 需要更高权限才能验证特定风险。

## Next Recommended Steps

- 针对 finding 开新 task
- 在发布前补跑 `$review`、`$qa` 或 `$investigate`
