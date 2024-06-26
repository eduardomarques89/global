﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;

namespace w7startup
{
    public static class IuguClient
    {
        /// <summary>
        /// Propriedades do cliente.
        /// </summary>
        public static IuguClientProperties Properties { get; internal set; }

        /// <summary>
        /// Atualiza as propriedades do cliente.
        /// </summary>
        /// <param name="properties"></param>
        public static void Init(IuguClientProperties properties)
        {
            Properties = properties;
        }
    }

    /// <summary>
    /// Propriedades do cliente.
    /// </summary>
    public class IuguClientProperties
    {
        /// <summary>
        /// API Key encontrada no painel administrativo da IUGU.
        /// </summary>
        public string ApiKey { get; set; }
    }
}