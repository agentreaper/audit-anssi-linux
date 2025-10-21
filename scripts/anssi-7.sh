function checkIOMMU(){
    if cat /proc/cmdline | grep -q 'intel_iommu=on' || \
       cat /proc/cmdline | grep -q 'amd_iommu=force_isolation' || \
       cat /proc/cmdline | grep -q 'iommu=pt'; then
        return 0
    else
        return 1
    fi
}

if checkIOMMU; then
    echo "IOMMU is enabled"
else
    echo "IOMMU is not enabled"
fi