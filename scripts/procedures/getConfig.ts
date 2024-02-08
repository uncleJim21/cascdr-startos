import { compat, types as T } from "../deps.ts";

export const getConfig: T.ExpectedExports.getConfig = compat.getConfig({
  "nodes": {
    "type": "list",
    "subtype": "union",
    "name": "Lightning Nodes",
    "description": "List of Lightning Network node instances to manage",
    "range": "[1,*)",
    "default": [
      "lnd"
    ],
    "spec": {
      "type": "string",
      "display-as": "{{name}}",
      "unique-by": "name",
      "name": "Node Implementation",
      "tag": {
        "id": "type",
        "name": "Type",
        "description": "- LND: Lightning Network Daemon from Lightning Labs\n- CLN: Core Lightning from Blockstream\n",
        "variant-names": {
          "lnd": "Lightning Network Daemon (LND)",
          "c-lightning": "Core Lightning (CLN)"
        }
      },
      "default": "lnd",
      "variants": {
        "lnd": {
          "name": {
            "type": "string",
            "name": "Node Name",
            "description": "Name of this node in the list",
            "default": "StartOS LND",
            "nullable": false
          },
          "connection-settings": {
            "type": "union",
            "name": "Connection Settings",
            "description": "The Lightning Network Daemon node to connect to.",
            "tag": {
              "id": "type",
              "name": "Type",
              "description": "- Internal: The Lightning Network Daemon service installed to your StartOS server.\n- External: A Lightning Network Daemon instance running on a remote device (advanced).\n",
              "variant-names": {
                "internal": "Internal"
              }
            },
            "default": "internal",
            "variants": {
              "internal": {},
            }
          }
        },
      }
    }
  },
  "open_ai_api_key": {
    "type": "string",
    "name": "Open AI API Key",
    "description": "Enter your OpenAI Key so that CASCDR can make requests on your customer's behalf in exchange for sats.",
    "nullable": false,
    "copyable": true,
    "masked": true
  },
  "nostr-nsec": {
    "type": "string",
    "name": "Nostr nsec",
    "description": "Enter the nsec to use when signing NIP105 advertisements on behalf of your service.",
    "nullable": false,
    "copyable": true,
    "masked": true
  },
  "chat_gpt_price_usd": {
    "type": "string",
    "name": "ChatGPT Price (USD)",
    "description": "Enter the price per ChatGPT call in USD (ex. 0.0125)",
    "nullable": false,
    "copyable": false,
    "masked": false
  },
  "tor-address": {
    "name": "Tor Address",
    "description": "The Tor address of the network interface",
    "type": "pointer",
    "subtype": "package",
    "package-id": "cascdr",
    "target": "tor-address",
    "interface": "rest",
  },
  "lan-address": {
      "name": "LAN Address",
      "description": "The LAN address for the network interface.",
      "type": "pointer",
      "subtype": "package",
      "package-id": "cascdr",
      "target": "lan-address",
      "interface": "rest",
  },
} as T.ConfigSpec);