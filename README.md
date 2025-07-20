# Helios AI Research Agent

This repository contains the backend logic for an AI-powered research agent, as detailed in my research paper, ["The Architect-Executor Model..."](https://link-to-your-paper).

## Overview

This project uses a GitHub Actions workflow to implement a multi-agent research system. It takes a complex topic as input and leverages the Google Gemini API to generate a structured, comprehensive research report.

The methodology follows the "Architect-Executor Model," where the human provides the strategic framework (the workflow and prompts) and the AI (Gemini) acts as the executor to plan, search, and synthesize the information.

## How It Works

The core of the project is the `.github/workflows/run_research.yml` file. It orchestrates a "Single-Step Synthesis" process:

1.  **Receive Topic:** A user provides a research topic via the GitHub Actions interface.
2.  **Prompt Gemini:** A detailed prompt instructs the Gemini model to internally perform three steps: planning (decomposing the topic), searching (gathering information), and synthesizing (writing the final report).
3.  **Output Report:** The final, structured report is printed to the GitHub Actions log.

**Note on Security:** The `GEMINI_API_KEY` is stored securely as a GitHub repository secret and is not exposed in the public code.

## How to Use

1.  Go to the **"Actions"** tab of this repository.
2.  Select the **"Run Helios AI Research Agent"** workflow on the left.
3.  Click the **"Run workflow"** button.
4.  Enter the research topic you want to explore in the input box.
5.  Click the green "Run workflow" button to start the job.
6.  Click on the newly started workflow run to view its progress and see the final report in the logs.

### Live Demo

A user-friendly version of this tool can be accessed on CodePen: [https://codepen.io/tanivashraf/pen/GgpgxBY](https://codepen.io/tanivashraf/pen/GgpgxBY)
