# enterprise-dev-suite Workflow Diagrams

## 1. Overview

```mermaid
flowchart LR
    subgraph Phase0["Optional: /deep-research"]
        R1[トピック分析\nタスク分解]
        R2[直列調査\n+ 適応的再評価]
        R3[合成レポート]
        R1 --> R2 --> R3
    end

    subgraph Phase1["Phase 1: /feasibility-study"]
        F1[Spec読込]
        F2[コードベース調査\n+ Web調査]
        F3[方針候補作成\n+ 選択]
        F1 --> F2 --> F3
    end

    subgraph Phase2["Phase 2: /solution-design"]
        S1[Feasibility Report\n読込]
        S2[サブタスク分割\n+ 依存関係整理]
        S3[テストケース定義]
        S1 --> S2 --> S3
    end

    subgraph Phase3["Phase 3: /implement-tdd"]
        I1[Solution Design\n読込]
        I2[サブタスク毎に\nTDD実装]
        I3[統合テスト\n+ レポート]
        I1 --> I2 --> I3
    end

    Phase0 -. "research_report.md\n(-r flag)" .-> Phase1
    Phase1 -- "feasibility/feasibility_report.md" --> Phase2
    Phase2 -- "design/solution_design.md" --> Phase3

    style Phase0 fill:#f3e5f5,stroke:#9C27B0
    style Phase1 fill:#e8f4fd,stroke:#2196F3
    style Phase2 fill:#fff3e0,stroke:#FF9800
    style Phase3 fill:#e8f5e9,stroke:#4CAF50
```

---

## 2. Detailed Flow

### Deep Research (Optional)

```mermaid
flowchart TD
    Start(["/deep-research"]) --> Init["0. conventions.md読込\nリサーチトピック取得\n出力パス設定"]

    Init --> Decompose["1. タスク分解\nディメンション抽出\n3-8タスク設計"]
    Decompose --> Approve{"タスク承認\n(AskUser)"}
    Approve -- "修正" --> Decompose
    Approve -- "承認" --> Loop

    subgraph Loop["2. 調査ループ (自律・ヘッドレス)"]
        direction TD
        Investigate["claude -p: 調査実行\n(WebSearch/Grep/Read)"]
        Investigate --> Accumulate["キーファインディングス蓄積\naccumulated_findings.md"]
        Accumulate --> Adapt["claude -p: 適応評価\n残タスク再評価・修正"]
        Adapt --> NextTask{"次のタスク?"}
        NextTask -- "あり" --> Investigate
    end

    NextTask -- "全完了" --> Synthesize["3. 合成\nクロスリファレンス\nギャップ補完"]
    Synthesize --> Report["4. レポート生成\nresearch_report.md"]
    Report --> ReviewReport{"レポート承認\n(AskUser)"}
    ReviewReport -- "修正要求" --> Synthesize
    ReviewReport -- "承認" --> Complete["5. 完了"]
    Complete --> Branch{"feasibility-study\nに分岐?"}
    Branch -- "Yes" --> FS(["/feasibility-study -r report"])
    Branch -- "No" --> End([終了])

    style Start fill:#9C27B0,color:#fff
    style Loop fill:#f3e5f5
    style Approve fill:#fff9c4
    style ReviewReport fill:#fff9c4
    style Branch fill:#fff9c4
```

### Phase 1: Feasibility Study

```mermaid
flowchart TD
    Start(["/feasibility-study"]) --> Init["0. conventions.md読込\nタスク名決定\n出力パス設定"]

    Init --> Investigate
    subgraph Investigate["1. 並列調査"]
        direction LR
        E1["Explore:\n類似実装"]
        E2["Explore:\nテストパターン"]
        E3["Explore:\n影響範囲"]
        W1["Web Research:\nベストプラクティス"]
    end

    Investigate --> Clarify["2. 不明点確認\n+ 方針候補リスト作成\n+ document-summarizer で要約"]

    Clarify --> Select{"3. 方針選択\n(AskUser)"}
    Select -- "方針確定" --> Report
    Select -- "PoC検証" --> PoC["poc-feasibility-expert\nで検証実施"]
    Select -- "追加調査" --> AddResearch["追加調査実施\n(Explore / Web)"]
    PoC --> Select
    AddResearch --> Select

    Report["4. 最終レポート作成\nfeasibility/feasibility_report.md"]
    Report --> Complete["5. タスク完了"]

    style Start fill:#2196F3,color:#fff
    style Investigate fill:#e3f2fd
    style Select fill:#fff9c4
```

### Phase 2: Solution Design

```mermaid
flowchart TD
    Start(["/solution-design"]) --> Init["0. conventions.md読込\nFeasibility Report取得\nタスク作成"]

    Init --> Analyze["1. Report読込\n要件整理 + 実装項目\n+ 高レベルテストケース"]
    Analyze --> Approve1{"2. Initial Design\n承認 (AskUser)"}
    Approve1 -- "修正要求" --> Analyze
    Approve1 -- "承認" --> DeepInvestigate

    subgraph DeepInvestigate["3. コードベース調査 + サブタスク分割"]
        direction LR
        D1["codebase-investigator"]
        D2["サブタスク分割\nMermaid依存関係図"]
    end

    DeepInvestigate --> SaveApprove
    subgraph SaveApprove["4. ドキュメント保存 + 承認"]
        Doc["design/solution_design.md 保存"]
        Summary["document-summarizer\nで要約表示"]
        Approve2{"最終承認\n(AskUser)"}
        Doc --> Summary --> Approve2
    end
    Approve2 -- "追加検討" --> AddStudy["追加調査\n+ ドキュメント更新"]
    AddStudy --> Approve2
    Approve2 -- "承認" --> Complete["5. タスク完了"]

    style Start fill:#FF9800,color:#fff
    style DeepInvestigate fill:#fff3e0
    style Approve1 fill:#fff9c4
    style Approve2 fill:#fff9c4
```

### Phase 3: TDD Implementation

```mermaid
flowchart TD
    Start(["/implement-tdd"]) --> Init["0. conventions.md読込\nSolution Design取得\nサブタスク・依存関係把握"]
    Init --> Branch["1. ブランチ作成\n+ チェックアウト"]

    Branch --> LoopStart{"2. 次の\nサブタスク?"}
    LoopStart -- "あり" --> DetailDesign

    subgraph SubtaskLoop["2. サブタスク実装ループ"]
        DetailDesign["a. 詳細設計\nテストケース定義"]
        DetailDesign --> ApproveDesign{"詳細設計\n承認?"}
        ApproveDesign -- "承認" --> TDD
        ApproveDesign -- "修正" --> DetailDesign

        TDD["b. TDD実装\ntdd-implementer agent\nRed → Green → Refactor"]
        TDD --> Retro["c. 振り返り\nギャップ記録"]
    end

    Retro --> LoopStart
    LoopStart -- "全完了" --> VerifyReport["3. 統合テスト実行\n+ 実装レポート作成\n+ PR Description"]
    VerifyReport --> Complete["4. タスク完了"]

    style Start fill:#4CAF50,color:#fff
    style SubtaskLoop fill:#e8f5e9
    style ApproveDesign fill:#fff9c4
```

### Supporting System

```mermaid
flowchart LR
    subgraph Skills["User-Invocable Skills"]
        DR["/deep-research"]
        FS["/feasibility-study"]
        SD["/solution-design"]
        IT["/implement-tdd"]
        SF["/small-feature"]
        GS["/generate-slides"]
    end

    subgraph Agents["Subagents"]
        EX["Explore\nコードベース探索"]
        CI["codebase-investigator\n3相反復探索"]
        WR["web-research-expert\n技術調査"]
        POC["poc-feasibility-expert\nPoC実装"]
        TDD["tdd-implementer\nTDD実装"]
        DS["document-summarizer\n要約生成"]
    end

    subgraph Conventions["Conventions"]
        CV["conventions.md\nDefaults テーブル"]
    end

    Skills --> Agents
    Conventions -.->|"Step 0で読込"| Skills

    style Agents fill:#e0f2f1,stroke:#009688
    style Conventions fill:#fafafa,stroke:#9E9E9E
```
