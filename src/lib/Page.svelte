<script lang="ts">
    let { children } = $props()
</script>

<div class="w-full flex flex-1 p-6 gap-3 items-center flex-col">
    {@render children()}
</div>