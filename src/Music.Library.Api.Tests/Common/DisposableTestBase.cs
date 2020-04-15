using Microsoft.AspNetCore.Mvc;
using System;

namespace Music.Library.Api.Tests.Common
{
    public class DisposableTestBase : IDisposable
    {
        private static Controller _controller;

        public static void RegisterForDispose(Controller controller) => _controller = controller ?? throw new ArgumentNullException(nameof(controller));

        protected virtual void Dispose(bool disposing)
        {
            if(disposing)
            {
                _controller.Dispose();
            }
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
    }
}
